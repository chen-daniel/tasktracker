defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tasks.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    belongs_to :created_by, Tasktracker.Accounts.User
    field :description, :string
    field :time, :naive_datetime
    field :title, :string
    belongs_to :assigned_to, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:created_by_id, :title, :description, :time, :completed, :assigned_to_id])
    |> validate_required([:created_by_id, :title, :description, :time, :completed, :assigned_to_id])
  end
end
