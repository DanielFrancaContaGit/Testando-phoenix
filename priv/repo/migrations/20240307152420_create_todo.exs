defmodule Hello.Repo.Migrations.CreateTodo do
  use Ecto.Migration

  def change do
    create table(:todo) do
      add :content, :string
      add :finished, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
