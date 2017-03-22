defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller
    alias Dbuniverse.{Character, CharacterQueries, CategoryQueries, Repo}

    def list(conn, %{"category" => category}) do

        characters = CharacterQueries.get_all category
        cat = category |> CategoryQueries.get_by_name

        conn
        |> assign(:header_url, cat["value"]["image_url"])
        |> render("list.html", [characters: characters, category: category])

    end

    def show(conn, %{"id" => id, "category" => category}) do

        character = CharacterQueries.get_by_id id
        
        conn
        |> assign(:header_url, "https://static.raru.co.za/news/header/2209.jpg?v=1462784678")
        |> render("details.html", [character: character, category: category])

    end

    def create(conn, %{"category" => category}) do

        character = Character.create_new_character(%Character{}, %{"category" => category})
        
        render conn, "create.html", [changeset: character, category: category, options: %{}]

    end

    def create(conn, %{error: changeset, category: category}) do

        render conn, "create.html", [changeset: changeset, category: category, options: %{}]

    end

    def add(conn, %{"character" => character, "category" => category}) do

        changeset = Character.create_new_character(%Character{}, character)

        case Repo.insert changeset do

            {:ok, %{"id" => id}} -> 
                    redirect conn, to: character_path(conn, :show, category, id)
            {:error, reasons} -> 
                    create conn, %{error: reasons, category: category}
        
        end      

    end

    def edit(conn, %{error: changeset, category: category, id: id, rev: rev}) do

        conn
        |> assign(:header_url, "https://static.raru.co.za/news/header/2209.jpg?v=1462784678")
        |> render("edit.html", [changeset: changeset, category: category, options: %{id: id, rev: rev}])

    end

    def edit(conn, %{"id" => id, "category" => category}) do

        character = CharacterQueries.get_by_id id
        changeset = Character.create_new_character(
                %Character{}, 
                %{
                    "name" => character["name"], 
                    "description" => character["description"], 
                    "category" => character["category"],
                    "image_url_tiny" => character["image_url_tiny"],
                    "image_url" => character["image_url"]
                }
            )
        
        conn
        |> assign(:header_url, "https://static.raru.co.za/news/header/2209.jpg?v=1462784678")
        |> render("edit.html", [changeset: changeset, category: category, options: %{id: id, rev: character["_rev"]}])

    end

    def update(conn, %{"character" => character, "id" => id, "rev" => rev, "category" => category}) do
        
        changeset = Character.create_new_character(%Character{}, character)

        case Repo.update(changeset, id, rev) do
            
            {:ok} ->
                    conn
                    |> put_flash(:info, "Character updated successfully.")
                    |> redirect(to: character_path(conn, :show, category, id))
            {:error, reasons} ->
                    edit conn, %{error: reasons, category: category, id: id, rev: rev}

        end

    end

    def delete(conn, %{"id" => id, "rev" => rev, "category" => category}) do
        
        Repo.delete id, rev
        redirect conn, to: character_path(conn, :list, category)

    end

end