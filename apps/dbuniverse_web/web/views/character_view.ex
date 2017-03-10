defmodule DbuniverseWeb.CharacterView do

    use DbuniverseWeb.Web, :view
    
    def create_or_update_action(conn, %{"id": id, "rev": rev}), do: character_path(conn, :update, id, rev)

    def create_or_update_action(conn, %{}), do: character_path(conn, :create)

end
