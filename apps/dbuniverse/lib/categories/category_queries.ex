defmodule Dbuniverse.CategoryQueries do
    
    alias Dbuniverse.Repo

    def get_all do
        
        Repo.get_all "category", "get_all"

    end

    def get_by_name name do
        
        Repo.get_by_key "category", "get_by_name", name

    end

end