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
    get "/:category/characters", CharacterController, :list
    get "/:category/characters/:id/edit", CharacterController, :edit
    put "/:category/characters/:id/update/:rev", CharacterController, :update
    get "/:category/characters/new", CharacterController, :create
    post "/:category/characters/new", CharacterController, :add
    get "/:category/characters/:id", CharacterController, :show
    delete "/:category/characters/:id/delete/:rev", CharacterController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", DbuniverseWeb do
  #   pipe_through :api
  # end
end
