defmodule BuDuoTravelWeb.HotelControllerTest do
  use BuDuoTravelWeb.ConnCase

  alias BuDuoTravel.Travel

  @create_attrs %{checkIn: "some checkIn", checkOut: "some checkOut", location: "some location"}
  @update_attrs %{checkIn: "some updated checkIn", checkOut: "some updated checkOut", location: "some updated location"}
  @invalid_attrs %{checkIn: nil, checkOut: nil, location: nil}

  def fixture(:hotel) do
    {:ok, hotel} = Travel.create_hotel(@create_attrs)
    hotel
  end

  describe "index" do
    test "lists all hotels", %{conn: conn} do
      conn = get conn, hotel_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Hotels"
    end
  end

  describe "new hotel" do
    test "renders form", %{conn: conn} do
      conn = get conn, hotel_path(conn, :new)
      assert html_response(conn, 200) =~ "New Hotel"
    end
  end

  describe "create hotel" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, hotel_path(conn, :create), hotel: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == hotel_path(conn, :show, id)

      conn = get conn, hotel_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Hotel"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, hotel_path(conn, :create), hotel: @invalid_attrs
      assert html_response(conn, 200) =~ "New Hotel"
    end
  end

  describe "edit hotel" do
    setup [:create_hotel]

    test "renders form for editing chosen hotel", %{conn: conn, hotel: hotel} do
      conn = get conn, hotel_path(conn, :edit, hotel)
      assert html_response(conn, 200) =~ "Edit Hotel"
    end
  end

  describe "update hotel" do
    setup [:create_hotel]

    test "redirects when data is valid", %{conn: conn, hotel: hotel} do
      conn = put conn, hotel_path(conn, :update, hotel), hotel: @update_attrs
      assert redirected_to(conn) == hotel_path(conn, :show, hotel)

      conn = get conn, hotel_path(conn, :show, hotel)
      assert html_response(conn, 200) =~ "some updated checkIn"
    end

    test "renders errors when data is invalid", %{conn: conn, hotel: hotel} do
      conn = put conn, hotel_path(conn, :update, hotel), hotel: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Hotel"
    end
  end

  describe "delete hotel" do
    setup [:create_hotel]

    test "deletes chosen hotel", %{conn: conn, hotel: hotel} do
      conn = delete conn, hotel_path(conn, :delete, hotel)
      assert redirected_to(conn) == hotel_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, hotel_path(conn, :show, hotel)
      end
    end
  end

  defp create_hotel(_) do
    hotel = fixture(:hotel)
    {:ok, hotel: hotel}
  end
end
