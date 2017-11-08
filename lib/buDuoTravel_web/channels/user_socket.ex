defmodule BuDuoTravelWeb.UserSocket do
  use Phoenix.Socket

  channel "rooms:*", BuDuoTravelWeb.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket
  

  def connect(%{"user" => user}, socket) do
    {:ok, assign(socket, :user, user)}
end

  def id(_socket), do: nil
end
