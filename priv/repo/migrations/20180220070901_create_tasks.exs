defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :created_by_id, references(:users, on_delete: :delete_all), null: false
      add :title, :string, null: false
      add :description, :text
      add :time, :naive_datetime, null: false
      add :completed, :boolean, default: false, null: false
      add :assigned_to_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:created_by_id])
    create index(:tasks, [:assigned_to_id])
  end
end
