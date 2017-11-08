defmodule BuDuoTravel.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :origin, :string
      add :destination, :string
      add :departure_date, :string

      timestamps()
    end

  end
end
