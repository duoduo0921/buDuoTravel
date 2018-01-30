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

   def flight_list(ori, des, date) do
    url = "https://api.sandbox.amadeus.com/v1.2/flights/low-fare-search?apikey=prBuA68WLoPMGqJ91KtRArlYap50quAB&origin=#{ori}&destination=#{des}&departure_date=#{date}"
    resp = HTTPoison.get!(url, [connect_timeout: 50_000, timeout: 50_000, recv_timeout: 50_000])
    data = Poison.decode!(resp.body)
    data["results"]
  end

  @doc false
  def changeset(%Flight{} = flight, attrs) do
    flight
    |> cast(attrs, [:origin, :destination, :departure_date])
    |> validate_required([:origin, :destination, :departure_date])
  end
end
