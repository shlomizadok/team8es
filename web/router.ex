defmodule Team8es.Router do
  use Team8es.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :require_login do
     plug Guardian.Plug.EnsureAuthenticated, handler: Team8es.Token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Team8es do
    pipe_through [:browser, :browser_session]
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions",SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  scope "/", Team8es do
    pipe_through [:browser, :browser_session, :require_login]
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Team8es do
  #   pipe_through :api
  # end
end
