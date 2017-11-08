defmodule BuDuoTravelWeb.ChatroomController do
  use BuDuoTravelWeb, :controller

  alias BuDuoTravel.Chat
  alias BuDuoTravel.Chat.Chatroom

  def index(conn, _params) do
    chatrooms = Chat.list_chatrooms()
    render(conn, "index.html", chatrooms: chatrooms)
  end

  def new(conn, _params) do
    changeset = Chat.change_chatroom(%Chatroom{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chatroom" => chatroom_params}) do
    case Chat.create_chatroom(chatroom_params) do
      {:ok, chatroom} ->
        conn
        |> put_flash(:info, "Chatroom created successfully.")
        |> redirect(to: chatroom_path(conn, :show, chatroom))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chatroom = Chat.get_chatroom!(id)
    render(conn, "show.html", chatroom: chatroom)
  end

  def edit(conn, %{"id" => id}) do
    chatroom = Chat.get_chatroom!(id)
    changeset = Chat.change_chatroom(chatroom)
    render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chatroom" => chatroom_params}) do
    chatroom = Chat.get_chatroom!(id)

    case Chat.update_chatroom(chatroom, chatroom_params) do
      {:ok, chatroom} ->
        conn
        |> put_flash(:info, "Chatroom updated successfully.")
        |> redirect(to: chatroom_path(conn, :show, chatroom))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chatroom: chatroom, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chatroom = Chat.get_chatroom!(id)
    {:ok, _chatroom} = Chat.delete_chatroom(chatroom)

    conn
    |> put_flash(:info, "Chatroom deleted successfully.")
    |> redirect(to: chatroom_path(conn, :index))
  end
end
