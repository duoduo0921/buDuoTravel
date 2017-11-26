defmodule BuDuoTravelWeb.DiaryController do
  use BuDuoTravelWeb, :controller

  alias BuDuoTravel.Social
  alias BuDuoTravel.Social.Diary

  def index(conn, _params) do
    diaries = Enum.reverse(Social.list_diaries())
    render(conn, "index.html", diaries: diaries)
end


  def new(conn, _params) do
    changeset = Social.change_diary(%Diary{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"diary" => diary_params}) do
    case Social.create_diary(diary_params) do
      {:ok, diary} ->
        conn
        |> put_flash(:info, "Diary created successfully.")
        |> redirect(to: diary_path(conn, :show, diary))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diary = Social.get_diary!(id)
    render(conn, "show.html", diary: diary)
  end

  def edit(conn, %{"id" => id}) do
    diary = Social.get_diary!(id)
    changeset = Social.change_diary(diary)
    render(conn, "edit.html", diary: diary, changeset: changeset)
  end

  def update(conn, %{"id" => id, "diary" => diary_params}) do
    diary = Social.get_diary!(id)

    case Social.update_diary(diary, diary_params) do
      {:ok, diary} ->
        conn
        |> put_flash(:info, "Diary updated successfully.")
        |> redirect(to: diary_path(conn, :show, diary))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", diary: diary, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    diary = Social.get_diary!(id)
    {:ok, _diary} = Social.delete_diary(diary)

    conn
    |> put_flash(:info, "Diary deleted successfully.")
    |> redirect(to: diary_path(conn, :index))
  end
end
