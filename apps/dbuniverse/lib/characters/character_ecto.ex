defmodule Dbuniverse.EctoCharacter do
    
    use Ecto.Schema
    import Ecto.Changeset

    @required_fields [:name, :description]
    @optional_fields [:_id, :_rev, :category, :image_url, :type]

    schema "ectocharacters" do
        
        field :_id,         :string
        field :_rev,         :string
        field :category,    :string
        field :name,        :string
        field :image_url,   :string
        field :description, :string
        field :type,        :string

        timestamps()

    end

    def changeset(character, params \\ %{}) do
        character
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
    end

end