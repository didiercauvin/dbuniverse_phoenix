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

end