defmodule BuDuoTravel.Social.Diary do
  use Ecto.Schema
  import Ecto.Changeset
  alias BuDuoTravel.Social.Diary


  schema "diaries" do
    field :content, :string
    belongs_to :user, BuDuoTravel.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Diary{} = diary, attrs) do
    diary
    |> cast(attrs, [:user_id, :content])
    |> validate_required([:user_id, :content])
  end
end
