defmodule TasktrackerWeb.ManagementController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.Management

  def index(conn, _params) do
    managements = Accounts.list_managements()
    render(conn, "index.html", managements: managements)
  end

  def new(conn, _params) do
    changeset = Accounts.change_management(%Management{})
    all_users = Accounts.list_users
      |> Enum.map(&{&1.id, &1.id})
    render(conn, "new.html", changeset: changeset, all_users: all_users)
  end

  def create(conn, %{"management" => management_params}) do
    case Accounts.create_management(management_params) do
      {:ok, management} ->
        conn
        |> put_flash(:info, "Management created successfully.")
        |> redirect(to: page_path(conn, :dashboard))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    management = Accounts.get_management!(id)
    render(conn, "show.html", management: management)
  end

  def edit(conn, %{"id" => id}) do
    management = Accounts.get_management!(id)
    changeset = Accounts.change_management(management)
    render(conn, "edit.html", management: management, changeset: changeset)
  end

  def update(conn, %{"id" => id, "management" => management_params}) do
    management = Accounts.get_management!(id)

    case Accounts.update_management(management, management_params) do
      {:ok, management} ->
        conn
        |> put_flash(:info, "Management updated successfully.")
        |> redirect(to: management_path(conn, :show, management))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", management: management, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    management = Accounts.get_management!(id)
    {:ok, _management} = Accounts.delete_management(management)

    conn
    |> put_flash(:info, "Management deleted successfully.")
    |> redirect(to: page_path(conn, :dashboard))
  end
end
