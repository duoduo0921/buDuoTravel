defmodule BuDuoTravelWeb.HotelController do
  use BuDuoTravelWeb, :controller

  alias BuDuoTravel.Travel
  alias BuDuoTravel.Travel.Hotel

  def index(conn, _params) do
    changeset = Travel.change_hotel(%Hotel{})
    hotels = Travel.list_hotels()
    render(conn, "index.html", hotels: hotels, changeset: changeset)
  end

  def search(conn, %{"loc" => loc, "inn" => inn, "out" => out}) do
    changeset = Travel.change_hotel(%Hotel{})
    try do
    hotels = Travel.hotel_list(loc, inn, out)
    loc = loc
    inn = inn
    out = out
    render(conn, "searchHotels.html", hotels: hotels, loc: loc, inn: inn, out: out, changeset: changeset)
    rescue
      Protocol.UndefinedError -> render(conn, "error.html", changeset: changeset)
      HTTPoison.Error -> render(conn, "error.html", changeset: changeset)
      Poison.SyntaxError -> render(conn, "error.html", changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Travel.change_hotel(%Hotel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hotel" => hotel_params}) do
    case Travel.create_hotel(hotel_params) do
      {:ok, hotel} ->
        conn
        |> put_flash(:info, "Hotel created successfully.")
        |> redirect(to: hotel_path(conn, :show, hotel))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hotel = Travel.get_hotel!(id)
    render(conn, "show.html", hotel: hotel)
  end

  def edit(conn, %{"id" => id}) do
    hotel = Travel.get_hotel!(id)
    changeset = Travel.change_hotel(hotel)
    render(conn, "edit.html", hotel: hotel, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hotel" => hotel_params}) do
    hotel = Travel.get_hotel!(id)

    case Travel.update_hotel(hotel, hotel_params) do
      {:ok, hotel} ->
        conn
        |> put_flash(:info, "Hotel updated successfully.")
        |> redirect(to: hotel_path(conn, :show, hotel))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hotel: hotel, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hotel = Travel.get_hotel!(id)
    {:ok, _hotel} = Travel.delete_hotel(hotel)

    conn
    |> put_flash(:info, "Hotel deleted successfully.")
    |> redirect(to: hotel_path(conn, :index))
  end
end
