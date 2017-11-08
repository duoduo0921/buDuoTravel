defmodule BuDuoTravelWeb.ChatroomControllerTest do
  use BuDuoTravelWeb.ConnCase

  alias BuDuoTravel.Chat

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:chatroom) do
    {:ok, chatroom} = Chat.create_chatroom(@create_attrs)
    chatroom
  end

  describe "index" do
    test "lists all chatrooms", %{conn: conn} do
      conn = get conn, chatroom_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Chatrooms"
    end
  end

  describe "new chatroom" do
    test "renders form", %{conn: conn} do
      conn = get conn, chatroom_path(conn, :new)
      assert html_response(conn, 200) =~ "New Chatroom"
    end
  end

  describe "create chatroom" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, chatroom_path(conn, :create), chatroom: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == chatroom_path(conn, :show, id)

      conn = get conn, chatroom_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Chatroom"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, chatroom_path(conn, :create), chatroom: @invalid_attrs
      assert html_response(conn, 200) =~ "New Chatroom"
    end
  end

  describe "edit chatroom" do
    setup [:create_chatroom]

    test "renders form for editing chosen chatroom", %{conn: conn, chatroom: chatroom} do
      conn = get conn, chatroom_path(conn, :edit, chatroom)
      assert html_response(conn, 200) =~ "Edit Chatroom"
    end
  end

  describe "update chatroom" do
    setup [:create_chatroom]

    test "redirects when data is valid", %{conn: conn, chatroom: chatroom} do
      conn = put conn, chatroom_path(conn, :update, chatroom), chatroom: @update_attrs
      assert redirected_to(conn) == chatroom_path(conn, :show, chatroom)

      conn = get conn, chatroom_path(conn, :show, chatroom)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, chatroom: chatroom} do
      conn = put conn, chatroom_path(conn, :update, chatroom), chatroom: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Chatroom"
    end
  end

  describe "delete chatroom" do
    setup [:create_chatroom]

    test "deletes chosen chatroom", %{conn: conn, chatroom: chatroom} do
      conn = delete conn, chatroom_path(conn, :delete, chatroom)
      assert redirected_to(conn) == chatroom_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, chatroom_path(conn, :show, chatroom)
      end
    end
  end

  defp create_chatroom(_) do
    chatroom = fixture(:chatroom)
    {:ok, chatroom: chatroom}
  end
end
