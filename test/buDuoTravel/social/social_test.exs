defmodule BuDuoTravel.SocialTest do
  use BuDuoTravel.DataCase

  alias BuDuoTravel.Social

  describe "diaries" do
    alias BuDuoTravel.Social.Diary

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def diary_fixture(attrs \\ %{}) do
      {:ok, diary} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_diary()

      diary
    end

    test "list_diaries/0 returns all diaries" do
      diary = diary_fixture()
      assert Social.list_diaries() == [diary]
    end

    test "get_diary!/1 returns the diary with given id" do
      diary = diary_fixture()
      assert Social.get_diary!(diary.id) == diary
    end

    test "create_diary/1 with valid data creates a diary" do
      assert {:ok, %Diary{} = diary} = Social.create_diary(@valid_attrs)
      assert diary.content == "some content"
    end

    test "create_diary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_diary(@invalid_attrs)
    end

    test "update_diary/2 with valid data updates the diary" do
      diary = diary_fixture()
      assert {:ok, diary} = Social.update_diary(diary, @update_attrs)
      assert %Diary{} = diary
      assert diary.content == "some updated content"
    end

    test "update_diary/2 with invalid data returns error changeset" do
      diary = diary_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_diary(diary, @invalid_attrs)
      assert diary == Social.get_diary!(diary.id)
    end

    test "delete_diary/1 deletes the diary" do
      diary = diary_fixture()
      assert {:ok, %Diary{}} = Social.delete_diary(diary)
      assert_raise Ecto.NoResultsError, fn -> Social.get_diary!(diary.id) end
    end

    test "change_diary/1 returns a diary changeset" do
      diary = diary_fixture()
      assert %Ecto.Changeset{} = Social.change_diary(diary)
    end
  end
end
