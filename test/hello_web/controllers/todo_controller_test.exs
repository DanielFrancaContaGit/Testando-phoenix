defmodule HelloWeb.TodoControllerTest do
  use HelloWeb.ConnCase

  import Hello.TodosFixtures

  @create_attrs %{finished: true, content: "some content"}
  @update_attrs %{finished: false, content: "some updated content"}
  @invalid_attrs %{finished: nil, content: nil}

  describe "index" do
    test "lists all todo", %{conn: conn} do
      conn = get(conn, ~p"/todo")
      assert html_response(conn, 200) =~ "Listing Todo"
    end
  end

  describe "new todo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/todo/new")
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "create todo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/todo", todo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/todo/#{id}"

      conn = get(conn, ~p"/todo/#{id}")
      assert html_response(conn, 200) =~ "Todo #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/todo", todo: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Todo"
    end
  end

  describe "edit todo" do
    setup [:create_todo]

    test "renders form for editing chosen todo", %{conn: conn, todo: todo} do
      conn = get(conn, ~p"/todo/#{todo}/edit")
      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "redirects when data is valid", %{conn: conn, todo: todo} do
      conn = put(conn, ~p"/todo/#{todo}", todo: @update_attrs)
      assert redirected_to(conn) == ~p"/todo/#{todo}"

      conn = get(conn, ~p"/todo/#{todo}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put(conn, ~p"/todo/#{todo}", todo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Todo"
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do
      conn = delete(conn, ~p"/todo/#{todo}")
      assert redirected_to(conn) == ~p"/todo"

      assert_error_sent 404, fn ->
        get(conn, ~p"/todo/#{todo}")
      end
    end
  end

  defp create_todo(_) do
    todo = todo_fixture()
    %{todo: todo}
  end
end
