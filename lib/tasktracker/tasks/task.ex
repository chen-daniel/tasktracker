defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tasks.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :created_by, :string
    field :description, :string
    field :time, :naive_datetime
    field :title, :string
    belongs_to :assigned_to, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:created_by, :title, :description, :time, :completed, :assigned_to_id])
    |> validate_required([:created_by, :title, :description, :time, :completed, :assigned_to_id])
  end
end
