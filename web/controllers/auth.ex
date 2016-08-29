defmodule AuthApi.Auth do
  import Plug.Conn
  import Ecto.Query
  use Timex  
  alias AuthApi.Session
  alias AuthApi.Repo
  
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end
  
  def call(conn, _repo) do
    [token] = get_req_header(conn, "authorization")
    expiration = Timex.subtract(Timex.now,Duration.from_minutes(30))
    query = from s in AuthApi.Session, where: s.token == ^token and s.updated_at >= ^expiration
    case session = Repo.all(query) do
      [] -> conn
        |> Phoenix.Controller.text("You are not authenticated!")
        |> halt()
      session -> conn
    end
  end
end
