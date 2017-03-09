defmodule Dbuniverse.TestEcto do
    
    use Ecto.Schema
    import Ecto.Changeset

    schema "testectos" do
        field :title, :string
    end

    def changeset(e, params \\ %{}) do
        e
        |> cast(params, [:title])
        |> validate_required([:title])
    end

end