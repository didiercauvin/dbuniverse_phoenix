defmodule DbuniverseWeb.CategoryController do
  use DbuniverseWeb.Web, :controller

  alias Dbuniverse.CategoryQueries
  alias DbuniverseWeb.CharacterController

  def list(conn, _params) do

    categories = CategoryQueries.get_all
    render conn, "index.html", categories: categories
  
  end

  def show(conn, %{"id" => id}) do
    
     character_path(conn, :show, %{"category" => id})

  end

end
