# test/controllers/user_controller_test.exs
defmodule AuthApi.UserControllerTest do
  use AuthApi.ConnCase

  alias AuthApi.User
  @valid_attrs %{email: "foo@bar2.com", username: "mrfoobar", password: "s3cr3t"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)#["data"]["user_id"]
    assert Repo.get_by(User, email: "foo@bar2.com")
  end
  
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
