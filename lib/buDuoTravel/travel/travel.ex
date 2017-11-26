defmodule BuDuoTravel.Travel do
  @moduledoc """
  The Travel context.
  """

  import Ecto.Query, warn: false
  alias BuDuoTravel.Repo

  alias BuDuoTravel.Travel.Flight

  @doc """
  Returns the list of flights.

  ## Examples

      iex> list_flights()
      [%Flight{}, ...]

  """
  def list_flights do
    Repo.all(Flight)
  end

  def flight_list(ori, des, date) do
    url = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=bi1I6W1GG7FjcTdSfS4UCO8H9NlNQC8k&origin=#{ori}&destination=#{des}&departure_date=#{date}"
    resp = HTTPoison.get!(url, [connect_timeout: 50_000, timeout: 50_000, recv_timeout: 50_000])
    data = Poison.decode!(resp.body)
    data["results"]
  end

  def hotel_list(loc, inn, out) do
    resp = HTTPoison.get!("https://api.sandbox.amadeus.com/v1.2/hotels/search-airport?apikey=bi1I6W1GG7FjcTdSfS4UCO8H9NlNQC8k&location=#{loc}&check_in=#{inn}&check_out=#{out}", [connect_timeout: 50_000, timeout: 50_000, recv_timeout: 50_000])
    data = Poison.decode!(resp.body)
    data["results"]
end

  @doc """
  Gets a single flight.

  Raises `Ecto.NoResultsError` if the Flight does not exist.

  ## Examples

      iex> get_flight!(123)
      %Flight{}

      iex> get_flight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flight!(id), do: Repo.get!(Flight, id)

  @doc """
  Creates a flight.

  ## Examples

      iex> create_flight(%{field: value})
      {:ok, %Flight{}}

      iex> create_flight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flight(attrs \\ %{}) do
    %Flight{}
    |> Flight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flight.

  ## Examples

      iex> update_flight(flight, %{field: new_value})
      {:ok, %Flight{}}

      iex> update_flight(flight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flight(%Flight{} = flight, attrs) do
    flight
    |> Flight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Flight.

  ## Examples

      iex> delete_flight(flight)
      {:ok, %Flight{}}

      iex> delete_flight(flight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flight(%Flight{} = flight) do
    Repo.delete(flight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flight changes.

  ## Examples

      iex> change_flight(flight)
      %Ecto.Changeset{source: %Flight{}}

  """
  def change_flight(%Flight{} = flight) do
    Flight.changeset(flight, %{})
  end
 

  alias BuDuoTravel.Travel.Hotel

  @doc """
  Returns the list of hotels.

  ## Examples

      iex> list_hotels()
      [%Hotel{}, ...]

  """
  def list_hotels do
    Repo.all(Hotel)
  end

  @doc """
  Gets a single hotel.

  Raises `Ecto.NoResultsError` if the Hotel does not exist.

  ## Examples

      iex> get_hotel!(123)
      %Hotel{}

      iex> get_hotel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hotel!(id), do: Repo.get!(Hotel, id)

  @doc """
  Creates a hotel.

  ## Examples

      iex> create_hotel(%{field: value})
      {:ok, %Hotel{}}

      iex> create_hotel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hotel(attrs \\ %{}) do
    %Hotel{}
    |> Hotel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hotel.

  ## Examples

      iex> update_hotel(hotel, %{field: new_value})
      {:ok, %Hotel{}}

      iex> update_hotel(hotel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hotel(%Hotel{} = hotel, attrs) do
    hotel
    |> Hotel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hotel.

  ## Examples

      iex> delete_hotel(hotel)
      {:ok, %Hotel{}}

      iex> delete_hotel(hotel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hotel(%Hotel{} = hotel) do
    Repo.delete(hotel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hotel changes.

  ## Examples

      iex> change_hotel(hotel)
      %Ecto.Changeset{source: %Hotel{}}

  """
  def change_hotel(%Hotel{} = hotel) do
    Hotel.changeset(hotel, %{})
  end
end
