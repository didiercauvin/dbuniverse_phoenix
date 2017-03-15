defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller
    alias Dbuniverse.{Character, CharacterQueries}

    def show(conn, %{"id" => id}) do

        character = CharacterQueries.get_by_id id
            # |> IO.inspect()

        render conn, "details.html", character: character

    end

    def list(conn, _params) do

        characters = CharacterQueries.get_all
        IO.inspect characters
        render conn, "list.html", characters: characters

    end

    def create(conn, _params) do

        changeset = Character.create_new_character(%Character{}, %{:name => "", :description => ""})
        render conn, "create.html", [changeset: changeset, options: %{}]

    end

    def add(conn, %{"character" => character}) do

        character_encoded = character 
                                |> Map.put(:type, "character")
                                |> Poison.encode!
        
        json = CharacterQueries.insert character_encoded
        redirect conn, to: character_path(conn, :show, json["id"])

    end

    def edit(conn, %{"id" => id}) do

        character = CharacterQueries.get_by_id id
        changeset = Character.create_new_character(
                %Character{}, 
                %{
                    :name => character["name"], 
                    :description => character["description"], 
                    :category => character["category"],
                    :image_url_tiny => character["image_url_tiny"],
                    :image_url => character["image_url"]
                }
            )
        
        # IO.inspect changeset
        render conn, "edit.html", [changeset: changeset, options: %{id: id, rev: character["_rev"]}]

    end

    def update(conn, %{"character" => character, "id" => id, "rev" => rev}) do
        
        IO.inspect character

        character = character 
                        |> Map.put(:_rev, rev)
                        |> Map.put(:type, "character")

        CharacterQueries.update(Poison.encode!(character), id)
        redirect conn, to: character_path(conn, :show, id)

    end

    def delete(conn, %{"id" => id, "rev" => rev}) do
        
        CharacterQueries.delete id, rev
        redirect conn, to: character_path(conn, :list)

    end

end