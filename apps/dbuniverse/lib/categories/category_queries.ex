defmodule Dbuniverse.CategoryQueries do
    
    alias Dbuniverse.Repo

    def get_all do
        
        Repo.get_all "category", "get_all"

    end

end