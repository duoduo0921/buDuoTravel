defmodule BuDuoTravel.Chat.Chatroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias BuDuoTravel.Chat.Chatroom


  schema "chatrooms" do

    timestamps()
  end

  @doc false
  def changeset(%Chatroom{} = chatroom, attrs) do
    chatroom
    |> cast(attrs, [])
    |> validate_required([])
  end
end
