defmodule Tasktracker.Accounts.Management do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.Management


  schema "managements" do
    belongs_to :manager, Tasktracker.Accounts.User
    belongs_to :underling, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Management{} = management, attrs) do
    management
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
