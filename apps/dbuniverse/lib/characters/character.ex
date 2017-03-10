defmodule Dbuniverse.Character do
    
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:name, :description]
    @optional_fields [:category, :image_url, :type]

    schema "character" do
        
        field :category,    :string
        field :name,        :string
        field :image_url,   :string
        field :description, :string
        field :type,        :string

        timestamps()

    end

    def create_new_character(character, params \\ %{}) do
        character
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
    end

end