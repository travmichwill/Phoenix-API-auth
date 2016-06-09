# test/controllers/session_controller_test.exs
defmodule AuthApi.SessionControllerTest do
  use AuthApi.ConnCase

  alias AuthApi.Session
  alias AuthApi.User
  @valid_attrs %{email: "foo@bar.com", password: "s3cr3t"}

  setup %{conn: conn} do
    changeset =  User.registration_changeset(%User{}, @valid_attrs)
    Repo.insert changeset
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @valid_attrs
    assert token = json_response(conn, 201)["data"]["token"]
    assert Repo.get_by(Session, token: token)
  end

  test "does not create resource and renders errors when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :password, "notright")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "does not create resource and renders errors when email is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :email, "not@found.com")
    assert json_response(conn, 401)["errors"] != %{}
  end

end