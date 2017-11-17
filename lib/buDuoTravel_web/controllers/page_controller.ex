defmodule BuDuoTravelWeb.PageController do
  use BuDuoTravelWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
