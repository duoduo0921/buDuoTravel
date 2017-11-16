defmodule BuDuoTravel.Travel.Hotel do
  use Ecto.Schema
  import Ecto.Changeset
  alias BuDuoTravel.Travel.Hotel


  schema "hotels" do
    field :checkIn, :string
    field :checkOut, :string
    field :location, :string

    timestamps()
  end


  @doc false
  def changeset(%Hotel{} = hotel, attrs) do
    hotel
    |> cast(attrs, [:location, :checkIn, :checkOut])
    |> validate_required([:location, :checkIn, :checkOut])
  end
end
