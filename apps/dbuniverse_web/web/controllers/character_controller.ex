defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller
    alias Dbuniverse.Character

    def show(conn, %{"id" => id}) do

        character = Dbuniverse.Repo.get_by_id id
            # |> IO.inspect()

        render conn, "details.html", character: character

    end

    def list(conn, _params) do

        characters = Dbuniverse.Repo.get_all
        render conn, "list.html", characters: characters

    end

    def create(conn, _params) do

        changeset = Character.create_new_character(%Character{}, %{:name => "", :description => ""})
        render conn, "edit.html", [changeset: changeset, options: %{}]

    end

    def add(conn, %{"character" => character}) do

        character = Map.put(character, :type, "character")
        character = Poison.encode! character
        json = Dbuniverse.Repo.insert character
        redirect conn, to: character_path(conn, :show, json["id"])

    end

    def edit(conn, %{"id" => id}) do

        character = Dbuniverse.Repo.get_by_id id
        changeset = Character.create_new_character(
                %Character{}, 
                %{
                    :name => character["name"], 
                    :description => character["description"], 
                    :category => character["category"],
                    :image_url => character["image_url"]
                }
            )
        
        # IO.inspect changeset
        render conn, "edit.html", [changeset: changeset, options: %{id: id, rev: character["_rev"]}]

    end

    def update(conn, %{"character" => character, "id" => id, "rev" => rev}) do
        
        IO.inspect character

        character = Map.put(character, :_rev, rev)
        character = Map.put(character, :type, "character")
        
        IO.inspect character

        Dbuniverse.Repo.update(Poison.encode!(character), id)
        redirect conn, to: character_path(conn, :show, id)

    end

end