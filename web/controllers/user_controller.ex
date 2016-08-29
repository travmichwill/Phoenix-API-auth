defmodule AuthApi.UserController do
  use AuthApi.Web, :controller

  alias AuthApi.User

  def create(conn, user_params) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AuthApi.ChangesetView, "error.json", changeset: changeset)
    end
  end
  
  def show(conn, %{"id" => user_id}) do
    user = Repo.get(AuthApi.User, user_id)
    render conn, "show.json", user: user
  end
end
