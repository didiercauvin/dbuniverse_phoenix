defmodule Dbuniverse.CharacterQueries do

    alias Dbuniverse.Repo

    def get_by_id id do
        
        Repo.get_by_id id
        
    end

    def get_all do

        Repo.get_all "character", "by_name"

    end

    def insert character do
        
        Repo.insert character

    end

    def update character, id do
        
        Repo.update character, id

    end

    def delete id, rev do
        
        Repo.delete id, rev

    end

end