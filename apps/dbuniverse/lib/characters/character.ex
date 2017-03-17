defmodule Dbuniverse.Character do
    
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:name, :description, :category, :image_url_header, :image_url_tiny, :image_url]
    @optional_fields [:type]

    schema "character" do
        
        field :category,            :string
        field :name,                :string
        field :image_url_header,    :string
        field :image_url_tiny,      :string
        field :image_url,           :string
        field :description,         :string
        field :type,                :string

        timestamps()

    end

    def create_new_character(character, params \\ %{}) do
        character
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
        |> validate_length(:name, min: 2)
    end

end