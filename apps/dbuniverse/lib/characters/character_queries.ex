defmodule Dbuniverse.CharacterQueries do

    alias Dbuniverse.Repo

    def get_by_id id do
        
        Repo.get_by_id id
        
    end

    def get_all category do

        Repo.get_all "character", "by_category_" <> category

    end

end