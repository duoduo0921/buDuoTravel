defmodule BuDuoTravel.ChatTest do
  use BuDuoTravel.DataCase

  alias BuDuoTravel.Chat

  describe "chatrooms" do
    alias BuDuoTravel.Chat.Chatroom

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def chatroom_fixture(attrs \\ %{}) do
      {:ok, chatroom} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_chatroom()

      chatroom
    end

    test "list_chatrooms/0 returns all chatrooms" do
      chatroom = chatroom_fixture()
      assert Chat.list_chatrooms() == [chatroom]
    end

    test "get_chatroom!/1 returns the chatroom with given id" do
      chatroom = chatroom_fixture()
      assert Chat.get_chatroom!(chatroom.id) == chatroom
    end

    test "create_chatroom/1 with valid data creates a chatroom" do
      assert {:ok, %Chatroom{} = chatroom} = Chat.create_chatroom(@valid_attrs)
    end

    test "create_chatroom/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_chatroom(@invalid_attrs)
    end

    test "update_chatroom/2 with valid data updates the chatroom" do
      chatroom = chatroom_fixture()
      assert {:ok, chatroom} = Chat.update_chatroom(chatroom, @update_attrs)
      assert %Chatroom{} = chatroom
    end

    test "update_chatroom/2 with invalid data returns error changeset" do
      chatroom = chatroom_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_chatroom(chatroom, @invalid_attrs)
      assert chatroom == Chat.get_chatroom!(chatroom.id)
    end

    test "delete_chatroom/1 deletes the chatroom" do
      chatroom = chatroom_fixture()
      assert {:ok, %Chatroom{}} = Chat.delete_chatroom(chatroom)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_chatroom!(chatroom.id) end
    end

    test "change_chatroom/1 returns a chatroom changeset" do
      chatroom = chatroom_fixture()
      assert %Ecto.Changeset{} = Chat.change_chatroom(chatroom)
    end
  end
end
