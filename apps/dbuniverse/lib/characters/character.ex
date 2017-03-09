defmodule Dbuniverse.Character do

    @derive [Poison.Encoder]
    defstruct [:_id, :_rev, :category, :name, :image_url, :description, :type]

end
