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

        # IO.inspect(params)
        c = Poison.encode! character
        json = Dbuniverse.Repo.insert c
        redirect conn, to: character_path(conn, :show, json["id"])

    end

end