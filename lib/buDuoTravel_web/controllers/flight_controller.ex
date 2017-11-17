defmodule BuDuoTravelWeb.FlightController do
  use BuDuoTravelWeb, :controller

  alias BuDuoTravel.Travel
  alias BuDuoTravel.Travel.Flight

  def index(conn, _params) do
    changeset = Travel.change_flight(%Flight{})
    flights = Travel.list_flights()
    render(conn, "index.html", flights: flights, changeset: changeset)
  end

  def search(conn, %{"ori" => ori, "des" => des, "dep" => dep}) do
    changeset = Travel.change_flight(%Flight{})
    try do
       flights = Travel.flight_list(ori, des, dep)  
       render(conn, "searchFlights.html", flights: flights, changeset: changeset)
    rescue
      Protocol.UndefinedError -> render(conn, "error.html", changeset: changeset)
      HTTPoison.Error -> render(conn, "error.html", changeset: changeset)
    end
  end
    

  def new(conn, _params) do
    changeset = Travel.change_flight(%Flight{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"flight" => flight_params}) do
    case Travel.create_flight(flight_params) do
      {:ok, flight} ->
        conn
        |> put_flash(:info, "Flight created successfully.")
        |> redirect(to: flight_path(conn, :show, flight))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = Travel.get_flight!(id)
    render(conn, "show.html", flight: flight)
  end

  def edit(conn, %{"id" => id}) do
    flight = Travel.get_flight!(id)
    changeset = Travel.change_flight(flight)
    render(conn, "edit.html", flight: flight, changeset: changeset)
  end

  def update(conn, %{"id" => id, "flight" => flight_params}) do
    flight = Travel.get_flight!(id)

    case Travel.update_flight(flight, flight_params) do
      {:ok, flight} ->
        conn
        |> put_flash(:info, "Flight updated successfully.")
        |> redirect(to: flight_path(conn, :show, flight))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flight: flight, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    flight = Travel.get_flight!(id)
    {:ok, _flight} = Travel.delete_flight(flight)

    conn
    |> put_flash(:info, "Flight deleted successfully.")
    |> redirect(to: flight_path(conn, :index))
  end
end
