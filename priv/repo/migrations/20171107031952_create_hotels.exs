defmodule BuDuoTravel.Repo.Migrations.CreateHotels do
  use Ecto.Migration

  def change do
    create table(:hotels) do
      add :location, :string
      add :checkIn, :string
      add :checkOut, :string

      timestamps()
    end

  end
end
