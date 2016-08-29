defmodule AuthApi.Router do
  use AuthApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  
  pipeline :authenticate do
    plug AuthApi.Auth, repo: AuthApi.Repo
  end

  scope "/", AuthApi do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  # Scope Requiring Authentication
  scope "/api", AuthApi do
    pipe_through [:api, :authenticate]
    resources "/user", UserController, only: [:show]
  end
  
  # Scope Not Requiring Authentication
  scope "/api", AuthApi do
    pipe_through :api
    resources "/user", UserController, only: [:create]
    resources "/session", SessionController, only: [:create]
  end
end
