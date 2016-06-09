# Not Currently in use!
defmodule AuthApi.Auth do
  import Plug.Conn
  
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end
  
  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
	#user_id = fetch_session(conn, :user_id)
	user = user_id && repo.get(AuthApi.User, user_id)
	assign(conn, :current_user, user)
  end
  
  def login(conn, user) do
    conn
	|> assign(:current_user, user)
	|> put_session(:user_id, user.id)
	|> configure_session(renew: true)
  end
end
