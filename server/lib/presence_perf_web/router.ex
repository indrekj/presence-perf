defmodule PresencePerfWeb.Router do
  use PresencePerfWeb, :router

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

  scope "/", PresencePerfWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/:page_id/online_user_count", PageController, :online_user_count
  end

  # Other scopes may use custom stacks.
  # scope "/api", PresencePerfWeb do
  #   pipe_through :api
  # end
end
