defmodule Dbuniverse.Character do
    
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:name, :description, :category, :image_url, :type]
    @optional_fields [:image_url_tiny]

    schema "character" do
        
        field :category,            :string
        field :name,                :string
        field :image_url_tiny,      :string
        field :image_url,           :string
        field :description,         :string
        field :type,                :string

    end

    def create_new_character(character, params \\ %{}) do
        params = Map.put(params, "type", "character")
        character
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
        # |> validate_length(:name, min: 2)
    end

end