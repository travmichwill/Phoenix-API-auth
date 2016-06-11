defmodule AuthApi.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias AuthApi.Session
  alias AuthApi.Repo
  
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end
  
  def call(conn, _repo) do
	[token] = get_req_header(conn, "authorization")
	case session = Repo.get_by(Session, token: token) do
	  nil -> conn
	    |> Phoenix.Controller.text("You are not authenticated!")
	    |> halt()
	  session -> conn
	end

  end
end
