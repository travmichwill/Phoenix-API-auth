defmodule AuthApi.UserController do
  use AuthApi.Web, :controller

  alias AuthApi.User

  #plug :scrub_params, "email" when action in [:create]
  plug :authenticate when action in [:show]

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
  
  def show(conn, %{"id" => user_id}) do
	user = Repo.get(AuthApi.User, user_id)
	render conn, "show.json", user: user
  end
  
  defp authenticate(conn, _opts) do
	# conn.assigns.current_user does not work Page: 79
	# Fix: https://robots.thoughtbot.com/testing-elixir-plugs
    if conn.assigns[:current_user] do
	  conn
	else
	  conn
	  |> text("You are not authenticated!")
	  |> halt()
	end
  end
end
