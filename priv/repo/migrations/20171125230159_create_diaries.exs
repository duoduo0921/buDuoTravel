defmodule BuDuoTravel.Repo.Migrations.CreateDiaries do
  use Ecto.Migration

  def change do
    create table(:diaries) do
      add :content, :string


      timestamps()
    end

  end
end
