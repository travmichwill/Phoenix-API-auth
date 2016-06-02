defmodule AuthApi.PageController do
  use AuthApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
