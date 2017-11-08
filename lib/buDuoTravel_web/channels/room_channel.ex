defmodule BuDuoTravelWeb.RoomChannel do
  use Phoenix.Channel
  alias BuDuoTravelWeb.Presence

  def join("rooms:lobby", _message, socket) do
    send self(), :after_join
    {:ok, socket}
  end

  def join(_room, _params, _socket) do
    {:error, %{reason: "you can only join the lobby"}}
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("message:new", message, socket) do
    broadcast! socket, "message:new", %{
      user: @current_user,
      body: message,
      timestamp: :os.system_time(:milli_seconds)
     }
    {:noreply, socket}
  end
end
