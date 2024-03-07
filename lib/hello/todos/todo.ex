defmodule Hello.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo" do
    field :finished, :boolean, default: false
    field :content, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:content, :finished])
    |> validate_required([:content, :finished])
  end
end
