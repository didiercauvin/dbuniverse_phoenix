defmodule Dbuniverse.CharacterQueries do

    alias Dbuniverse.Repo

    def get_by_id id do
        
        Repo.get_by_id id
        
    end

    def get_all category do

        Repo.get_all "character", "by_category_" <> category

    end

    def insert character do
       
        character
            |> Repo.insert 
        
    end

    def update character, id do
        
        Repo.update character, id

    end

    def delete id, rev do
        
        Repo.delete id, rev

    end

end