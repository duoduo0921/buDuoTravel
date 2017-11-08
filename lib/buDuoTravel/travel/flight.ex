defmodule BuDuoTravel.Travel.Flight do
  use Ecto.Schema
  import Ecto.Changeset
  alias BuDuoTravel.Travel.Flight


  schema "flights" do
    field :departure_date, :string
    field :destination, :string
    field :origin, :string

    timestamps()
  end

  @doc false
  def changeset(%Flight{} = flight, attrs) do
    flight
    |> cast(attrs, [:origin, :destination, :departure_date])
    |> validate_required([:origin, :destination, :departure_date])
  end
end
