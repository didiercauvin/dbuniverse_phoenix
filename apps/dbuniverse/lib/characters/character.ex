defmodule Dbuniverse.Character do

    @derive [Poison.Encoder]
    defstruct [:_id, :category, :name, :image_url, :description]

end
