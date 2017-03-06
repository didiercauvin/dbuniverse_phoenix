defmodule Dbuniverse.CharacterQueries do

    alias Dbuniverse.Repo

    def get_character_by_id id do
        
        character_json = Repo.get_by_id id
        

    end

end