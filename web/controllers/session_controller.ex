# web/controllers/session_controller.ex
defmodule AuthApi.SessionController do
  use AuthApi.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias AuthApi.User
  alias AuthApi.Session

  def create(conn, user_params) do
    user = Repo.get_by(User, username: user_params["username"])
    cond do
      user && checkpw(user_params["password"], user.password_hash) ->
        session_changeset = Session.registration_changeset(%Session{}, %{user_id: user.user_id})
		
		case session = Repo.get_by(Session, user_id: user.user_id) do
		  nil -> {:ok, session} = Session.registration_changeset(%Session{}, %{user_id: user.user_id})
		    |> Repo.insert()
		  session -> session = Session.registration_changeset(session, %{user_id: user.user_id})
		    |> Repo.update!()
		end

        conn
        |> put_status(:created)
        |> render("show.json", session: session)
      user ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
      true ->
        dummy_checkpw
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
    end
  end
end