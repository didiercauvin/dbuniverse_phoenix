defmodule Dbuniverse.Category do

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:name, :image_url, :type]

    schema "category" do
        
        field :name,        :string
        field :type,        :string
        field :image_url,   :string

    end

    def changeset(category, params \\ %{}) do
        params = Map.put(params, "type", "category")
        category
        |> cast(params, @required_fields)

    end

end