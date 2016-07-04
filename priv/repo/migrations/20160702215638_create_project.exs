defmodule TaskMaster.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
