defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller

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

        render conn, "create.html", conn: conn

    end

    def add(conn, %{"character" => character}) do

        IO.inspect(character)
        c = Poison.encode! character
        json = Dbuniverse.Repo.insert c
        redirect conn, to: character_path(conn, :show, json["id"])

    end

    def edit(conn, %{"id" => id}) do

        character = Dbuniverse.Repo.get_by_id id
        changeset = Dbuniverse.EctoCharacter.changeset(%Dbuniverse.EctoCharacter{}, %{_id: id, _rev: character["_rev"], name: character["name"], description: character["description"], image_url: character["image_url"], category: character["category"]})
        # IO.inspect changeset
        render conn, "edit.html", changeset: changeset

    end

    def update(conn, %{"ecto_character" => character, "id" => id}) do
        
        # json = Poison.encode! character

        IO.inspect character
        # IO.inspect json

        Dbuniverse.Repo.update character, id
        redirect conn, to: character_path(conn, :show, id)

    end

end