defmodule BuDuoTravel.Repo.Migrations.CreateChatrooms do
  use Ecto.Migration

  def change do
    create table(:chatrooms) do

      timestamps()
    end

  end
end
