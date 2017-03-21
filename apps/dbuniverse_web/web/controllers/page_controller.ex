defmodule DbuniverseWeb.PageController do
  use DbuniverseWeb.Web, :controller

  alias Dbuniverse.CategoryQueries

  def index(conn, _params) do

    categories = CategoryQueries.get_all

    IO.inspect(categories)

    render conn, "index.html", categories: categories
  
  end

  def show(conn, %{"id" => id}) do
    
    # render conn, 

  end

end
