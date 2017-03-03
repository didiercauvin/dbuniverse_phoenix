defmodule DbuniverseWeb.CharacterController do
    
    use DbuniverseWeb.Web, :controller

    def show(conn, %{"id" => id}) do

        character = Dbuniverse.Repo.get_by_id id
            # |> IO.inspect()

        render conn, "details.html", character: character

    end

end