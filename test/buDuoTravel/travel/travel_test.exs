defmodule BuDuoTravel.TravelTest do
  use BuDuoTravel.DataCase

  alias BuDuoTravel.Travel

  describe "flights" do
    alias BuDuoTravel.Travel.Flight

    @valid_attrs %{departure_date: "some departure_date", destination: "some destination", origin: "some origin"}
    @update_attrs %{departure_date: "some updated departure_date", destination: "some updated destination", origin: "some updated origin"}
    @invalid_attrs %{departure_date: nil, destination: nil, origin: nil}

    def flight_fixture(attrs \\ %{}) do
      {:ok, flight} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Travel.create_flight()

      flight
    end

    test "list_flights/0 returns all flights" do
      flight = flight_fixture()
      assert Travel.list_flights() == [flight]
    end

    test "get_flight!/1 returns the flight with given id" do
      flight = flight_fixture()
      assert Travel.get_flight!(flight.id) == flight
    end

    test "create_flight/1 with valid data creates a flight" do
      assert {:ok, %Flight{} = flight} = Travel.create_flight(@valid_attrs)
      assert flight.departure_date == "some departure_date"
      assert flight.destination == "some destination"
      assert flight.origin == "some origin"
    end

    test "create_flight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Travel.create_flight(@invalid_attrs)
    end

    test "update_flight/2 with valid data updates the flight" do
      flight = flight_fixture()
      assert {:ok, flight} = Travel.update_flight(flight, @update_attrs)
      assert %Flight{} = flight
      assert flight.departure_date == "some updated departure_date"
      assert flight.destination == "some updated destination"
      assert flight.origin == "some updated origin"
    end

    test "update_flight/2 with invalid data returns error changeset" do
      flight = flight_fixture()
      assert {:error, %Ecto.Changeset{}} = Travel.update_flight(flight, @invalid_attrs)
      assert flight == Travel.get_flight!(flight.id)
    end

    test "delete_flight/1 deletes the flight" do
      flight = flight_fixture()
      assert {:ok, %Flight{}} = Travel.delete_flight(flight)
      assert_raise Ecto.NoResultsError, fn -> Travel.get_flight!(flight.id) end
    end

    test "change_flight/1 returns a flight changeset" do
      flight = flight_fixture()
      assert %Ecto.Changeset{} = Travel.change_flight(flight)
    end
  end

  describe "hotels" do
    alias BuDuoTravel.Travel.Hotel

    @valid_attrs %{"check-in": "some check-in", "check-out": "some check-out", location: "some location"}
    @update_attrs %{"check-in": "some updated check-in", "check-out": "some updated check-out", location: "some updated location"}
    @invalid_attrs %{"check-in": nil, "check-out": nil, location: nil}

    def hotel_fixture(attrs \\ %{}) do
      {:ok, hotel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Travel.create_hotel()

      hotel
    end

    test "list_hotels/0 returns all hotels" do
      hotel = hotel_fixture()
      assert Travel.list_hotels() == [hotel]
    end

    test "get_hotel!/1 returns the hotel with given id" do
      hotel = hotel_fixture()
      assert Travel.get_hotel!(hotel.id) == hotel
    end

    test "create_hotel/1 with valid data creates a hotel" do
      assert {:ok, %Hotel{} = hotel} = Travel.create_hotel(@valid_attrs)
      assert hotel.check-in == "some check-in"
      assert hotel.check-out == "some check-out"
      assert hotel.location == "some location"
    end

    test "create_hotel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Travel.create_hotel(@invalid_attrs)
    end

    test "update_hotel/2 with valid data updates the hotel" do
      hotel = hotel_fixture()
      assert {:ok, hotel} = Travel.update_hotel(hotel, @update_attrs)
      assert %Hotel{} = hotel
      assert hotel.check-in == "some updated check-in"
      assert hotel.check-out == "some updated check-out"
      assert hotel.location == "some updated location"
    end

    test "update_hotel/2 with invalid data returns error changeset" do
      hotel = hotel_fixture()
      assert {:error, %Ecto.Changeset{}} = Travel.update_hotel(hotel, @invalid_attrs)
      assert hotel == Travel.get_hotel!(hotel.id)
    end

    test "delete_hotel/1 deletes the hotel" do
      hotel = hotel_fixture()
      assert {:ok, %Hotel{}} = Travel.delete_hotel(hotel)
      assert_raise Ecto.NoResultsError, fn -> Travel.get_hotel!(hotel.id) end
    end

    test "change_hotel/1 returns a hotel changeset" do
      hotel = hotel_fixture()
      assert %Ecto.Changeset{} = Travel.change_hotel(hotel)
    end
  end

  describe "hotels" do
    alias BuDuoTravel.Travel.Hotel

    @valid_attrs %{checkIn: "some checkIn", checkOut: "some checkOut", location: "some location"}
    @update_attrs %{checkIn: "some updated checkIn", checkOut: "some updated checkOut", location: "some updated location"}
    @invalid_attrs %{checkIn: nil, checkOut: nil, location: nil}

    def hotel_fixture(attrs \\ %{}) do
      {:ok, hotel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Travel.create_hotel()

      hotel
    end

    test "list_hotels/0 returns all hotels" do
      hotel = hotel_fixture()
      assert Travel.list_hotels() == [hotel]
    end

    test "get_hotel!/1 returns the hotel with given id" do
      hotel = hotel_fixture()
      assert Travel.get_hotel!(hotel.id) == hotel
    end

    test "create_hotel/1 with valid data creates a hotel" do
      assert {:ok, %Hotel{} = hotel} = Travel.create_hotel(@valid_attrs)
      assert hotel.checkIn == "some checkIn"
      assert hotel.checkOut == "some checkOut"
      assert hotel.location == "some location"
    end

    test "create_hotel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Travel.create_hotel(@invalid_attrs)
    end

    test "update_hotel/2 with valid data updates the hotel" do
      hotel = hotel_fixture()
      assert {:ok, hotel} = Travel.update_hotel(hotel, @update_attrs)
      assert %Hotel{} = hotel
      assert hotel.checkIn == "some updated checkIn"
      assert hotel.checkOut == "some updated checkOut"
      assert hotel.location == "some updated location"
    end

    test "update_hotel/2 with invalid data returns error changeset" do
      hotel = hotel_fixture()
      assert {:error, %Ecto.Changeset{}} = Travel.update_hotel(hotel, @invalid_attrs)
      assert hotel == Travel.get_hotel!(hotel.id)
    end

    test "delete_hotel/1 deletes the hotel" do
      hotel = hotel_fixture()
      assert {:ok, %Hotel{}} = Travel.delete_hotel(hotel)
      assert_raise Ecto.NoResultsError, fn -> Travel.get_hotel!(hotel.id) end
    end

    test "change_hotel/1 returns a hotel changeset" do
      hotel = hotel_fixture()
      assert %Ecto.Changeset{} = Travel.change_hotel(hotel)
    end
  end
end
