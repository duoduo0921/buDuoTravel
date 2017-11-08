defmodule BuDuoTravelWeb.FlightControllerTest do
  use BuDuoTravelWeb.ConnCase

  alias BuDuoTravel.Travel

  @create_attrs %{departure_date: "some departure_date", destination: "some destination", origin: "some origin"}
  @update_attrs %{departure_date: "some updated departure_date", destination: "some updated destination", origin: "some updated origin"}
  @invalid_attrs %{departure_date: nil, destination: nil, origin: nil}

  def fixture(:flight) do
    {:ok, flight} = Travel.create_flight(@create_attrs)
    flight
  end

  describe "index" do
    test "lists all flights", %{conn: conn} do
      conn = get conn, flight_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Flights"
    end
  end

  describe "new flight" do
    test "renders form", %{conn: conn} do
      conn = get conn, flight_path(conn, :new)
      assert html_response(conn, 200) =~ "New Flight"
    end
  end

  describe "create flight" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, flight_path(conn, :create), flight: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == flight_path(conn, :show, id)

      conn = get conn, flight_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Flight"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, flight_path(conn, :create), flight: @invalid_attrs
      assert html_response(conn, 200) =~ "New Flight"
    end
  end

  describe "edit flight" do
    setup [:create_flight]

    test "renders form for editing chosen flight", %{conn: conn, flight: flight} do
      conn = get conn, flight_path(conn, :edit, flight)
      assert html_response(conn, 200) =~ "Edit Flight"
    end
  end

  describe "update flight" do
    setup [:create_flight]

    test "redirects when data is valid", %{conn: conn, flight: flight} do
      conn = put conn, flight_path(conn, :update, flight), flight: @update_attrs
      assert redirected_to(conn) == flight_path(conn, :show, flight)

      conn = get conn, flight_path(conn, :show, flight)
      assert html_response(conn, 200) =~ "some updated departure_date"
    end

    test "renders errors when data is invalid", %{conn: conn, flight: flight} do
      conn = put conn, flight_path(conn, :update, flight), flight: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Flight"
    end
  end

  describe "delete flight" do
    setup [:create_flight]

    test "deletes chosen flight", %{conn: conn, flight: flight} do
      conn = delete conn, flight_path(conn, :delete, flight)
      assert redirected_to(conn) == flight_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, flight_path(conn, :show, flight)
      end
    end
  end

  defp create_flight(_) do
    flight = fixture(:flight)
    {:ok, flight: flight}
  end
end
