defmodule Hello.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        content: "some content",
        finished: true
      })
      |> Hello.Todos.create_todo()

    todo
  end
end
