defmodule AuthApi.SessionTest do
  use AuthApi.ModelCase

  alias AuthApi.Session

  @valid_attrs %{user_id: "e46eb2704a0949bf8d122ecded56fa61"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Session.changeset(%Session{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_changeset with valid attributes" do
    changeset = Session.changeset(%Session{}, @valid_attrs)
    assert changeset.changes.token
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end
end