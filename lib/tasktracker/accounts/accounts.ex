defmodule Tasktracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Management

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_assignable_users(conn) do
    current_id = Plug.Conn.get_session(conn, :user_id)
    query = from m in Management, where: m.manager_id == ^current_id, select: m.underling_id
    Repo.all(query)
      |> Enum.concat([current_id])
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # Based on Nat Tuck's notes
  def get_user(id), do: Repo.get(User, id)

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Returns the list of managements.

  ## Examples

      iex> list_managements()
      [%Management{}, ...]

  """
  def list_managements do
    Repo.all(Management)
  end

  def list_user_underlings(conn) do
    current_id = Plug.Conn.get_session(conn, :user_id)
    query = from m in Management, where: m.manager_id == ^current_id, select: m
    Repo.all(query)
  end

  @doc """
  Gets a single management.

  Raises `Ecto.NoResultsError` if the Management does not exist.

  ## Examples

      iex> get_management!(123)
      %Management{}

      iex> get_management!(456)
      ** (Ecto.NoResultsError)

  """
  def get_management!(id), do: Repo.get!(Management, id)

  @doc """
  Creates a management.

  ## Examples

      iex> create_management(%{field: value})
      {:ok, %Management{}}

      iex> create_management(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_management(attrs \\ %{}) do
    %Management{}
    |> Management.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a management.

  ## Examples

      iex> update_management(management, %{field: new_value})
      {:ok, %Management{}}

      iex> update_management(management, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_management(%Management{} = management, attrs) do
    management
    |> Management.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Management.

  ## Examples

      iex> delete_management(management)
      {:ok, %Management{}}

      iex> delete_management(management)
      {:error, %Ecto.Changeset{}}

  """
  def delete_management(%Management{} = management) do
    Repo.delete(management)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking management changes.

  ## Examples

      iex> change_management(management)
      %Ecto.Changeset{source: %Management{}}

  """
  def change_management(%Management{} = management) do
    Management.changeset(management, %{})
  end
end
