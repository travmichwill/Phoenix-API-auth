defmodule AuthApi.UserController do
  use AuthApi.Web, :controller

  alias AuthApi.User

  #plug :scrub_params, "email" when action in [:create]

  #def create(conn, %{"email" => user_params}) do
  def create(conn, user_params) do
    changeset = User.registration_changeset(%User{}, user_params)
	#IO.puts user_params
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AuthApi.ChangesetView, "error.json", changeset: changeset)
		# render conn, "show.json", data: Repo.get!(MyModel, params[:id])
    end
  end
end
