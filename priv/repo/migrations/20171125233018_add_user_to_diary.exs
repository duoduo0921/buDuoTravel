defmodule BuDuoTravel.Repo.Migrations.AddUserToDiary do
  use Ecto.Migration

  def change do

    alter table("diaries") do
       
    add :user_id, references(:users, on_delete: :delete_all) 

    end
  end
end
