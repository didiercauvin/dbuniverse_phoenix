defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller
    alias Dbuniverse.{Character, CharacterQueries}

    def list(conn, %{"category" => category}) do

        characters = CharacterQueries.get_all category
        
        conn
        |> assign(:header_url, "https://static.raru.co.za/news/header/2209.jpg?v=1462784678")
        |> render("list.html", [characters: characters, category: category])

    end

    def show(conn, %{"id" => id, "category" => category}) do

        character = CharacterQueries.get_by_id id
            # |> IO.inspect()
        
        conn
        |> assign(:header_url, character["image_url_header"])
        |> render("details.html", [character: character, category: category])

    end

    def create(conn, %{"category" => category}) do

        character = Character.create_new_character(%Character{}, %{:name => "", :description => "", :category => category})
        
        render conn, "create.html", [changeset: character, category: category, options: %{}]

    end

    def add(conn, %{"character" => character}) do

        IO.inspect character

        json = character 
                |> Map.put(:type, "character")
                |> Poison.encode!
                |> CharacterQueries.insert
        
        redirect conn, to: character_path(conn, :show, character["category"], json["id"])

    end

    def edit(conn, %{"id" => id, "category" => category}) do

        character = CharacterQueries.get_by_id id
        changeset = Character.create_new_character(
                %Character{}, 
                %{
                    :name => character["name"], 
                    :description => character["description"], 
                    :category => character["category"],
                    :image_url_tiny => character["image_url_tiny"],
                    :image_url_header => character["image_url_header"],
                    :image_url => character["image_url"]
                }
            )
        
        # IO.inspect changeset
        conn
        |> assign(:header_url, character["image_url_header"])
        |> render("edit.html", [changeset: changeset, category: category, options: %{id: id, rev: character["_rev"]}])

    end

    def update(conn, %{"character" => character, "id" => id, "rev" => rev, "category" => category}) do
        
        changeset = Character.create_new_character(
                         %Character{},
                        %{
                                :name => character["name"], 
                                :description => character["description"], 
                                :category => character["category"],
                                :image_url_tiny => character["image_url_tiny"],
                                :image_url_header => character["image_url_header"],
                                :image_url => character["image_url"]
                            }
                        )

        if changeset.valid? do
            
            character = character 
                        |> Map.put(:_rev, rev)
                        |> Map.put(:type, "character")

            CharacterQueries.update(Poison.encode!(character), id)
            
            conn
            |> put_flash(:info, "Character updated successfully.")
            |> redirect(to: character_path(conn, :show, category, id))

        else 
        
            render(conn, "edit.html", [changeset: changeset, category: category, options: %{id: id, rev: rev}])

        end

        

    end

    def delete(conn, %{"id" => id, "rev" => rev, "category" => category}) do
        
        CharacterQueries.delete id, rev
        redirect conn, to: character_path(conn, :list, category)

    end

end