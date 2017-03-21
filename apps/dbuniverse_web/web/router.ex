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

    get "/", CategoryController, :list
    get "/:id", CategoryController, :show
    
  end

  scope "/:category/characters", DbuniverseWeb do
    pipe_through :browser # Use the default browser stack

    get "/", CharacterController, :list
    get "/:id/edit", CharacterController, :edit
    put "/:id/update/:rev", CharacterController, :update
    get "/new", CharacterController, :create
    post "/new", CharacterController, :add
    get "/:id", CharacterController, :show
    delete "/:id/delete/:rev", CharacterController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", DbuniverseWeb do
  #   pipe_through :api
  # end
end
