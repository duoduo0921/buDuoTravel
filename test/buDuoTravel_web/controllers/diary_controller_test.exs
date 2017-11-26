defmodule BuDuoTravelWeb.DiaryControllerTest do
  use BuDuoTravelWeb.ConnCase

  alias BuDuoTravel.Social

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  def fixture(:diary) do
    {:ok, diary} = Social.create_diary(@create_attrs)
    diary
  end

  describe "index" do
    test "lists all diaries", %{conn: conn} do
      conn = get conn, diary_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Diaries"
    end
  end

  describe "new diary" do
    test "renders form", %{conn: conn} do
      conn = get conn, diary_path(conn, :new)
      assert html_response(conn, 200) =~ "New Diary"
    end
  end

  describe "create diary" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, diary_path(conn, :create), diary: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == diary_path(conn, :show, id)

      conn = get conn, diary_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Diary"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, diary_path(conn, :create), diary: @invalid_attrs
      assert html_response(conn, 200) =~ "New Diary"
    end
  end

  describe "edit diary" do
    setup [:create_diary]

    test "renders form for editing chosen diary", %{conn: conn, diary: diary} do
      conn = get conn, diary_path(conn, :edit, diary)
      assert html_response(conn, 200) =~ "Edit Diary"
    end
  end

  describe "update diary" do
    setup [:create_diary]

    test "redirects when data is valid", %{conn: conn, diary: diary} do
      conn = put conn, diary_path(conn, :update, diary), diary: @update_attrs
      assert redirected_to(conn) == diary_path(conn, :show, diary)

      conn = get conn, diary_path(conn, :show, diary)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, diary: diary} do
      conn = put conn, diary_path(conn, :update, diary), diary: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Diary"
    end
  end

  describe "delete diary" do
    setup [:create_diary]

    test "deletes chosen diary", %{conn: conn, diary: diary} do
      conn = delete conn, diary_path(conn, :delete, diary)
      assert redirected_to(conn) == diary_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, diary_path(conn, :show, diary)
      end
    end
  end

  defp create_diary(_) do
    diary = fixture(:diary)
    {:ok, diary: diary}
  end
end
