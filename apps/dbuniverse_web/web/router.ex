defmodule DbuniverseWeb.Router do
  use DbuniverseWeb.Web, :router

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

  scope "/", DbuniverseWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/characters", CharacterController, :list
    get "/characters/edit/:id", CharacterController, :edit
    put "/characters/update/:id/:rev", CharacterController, :update
    get "/characters/new", CharacterController, :create
    post "/characters/new", CharacterController, :add
    get "/characters/:id", CharacterController, :show
    delete "/characters/delete/:id/:rev", CharacterController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", DbuniverseWeb do
  #   pipe_through :api
  # end
end
