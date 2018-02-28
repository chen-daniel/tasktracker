defmodule Tasktracker.AccountsTest do
  use Tasktracker.DataCase

  alias Tasktracker.Accounts

  describe "users" do
    alias Tasktracker.Accounts.User

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "managements" do
    alias Tasktracker.Accounts.Management

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def management_fixture(attrs \\ %{}) do
      {:ok, management} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_management()

      management
    end

    test "list_managements/0 returns all managements" do
      management = management_fixture()
      assert Accounts.list_managements() == [management]
    end

    test "get_management!/1 returns the management with given id" do
      management = management_fixture()
      assert Accounts.get_management!(management.id) == management
    end

    test "create_management/1 with valid data creates a management" do
      assert {:ok, %Management{} = management} = Accounts.create_management(@valid_attrs)
    end

    test "create_management/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_management(@invalid_attrs)
    end

    test "update_management/2 with valid data updates the management" do
      management = management_fixture()
      assert {:ok, management} = Accounts.update_management(management, @update_attrs)
      assert %Management{} = management
    end

    test "update_management/2 with invalid data returns error changeset" do
      management = management_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_management(management, @invalid_attrs)
      assert management == Accounts.get_management!(management.id)
    end

    test "delete_management/1 deletes the management" do
      management = management_fixture()
      assert {:ok, %Management{}} = Accounts.delete_management(management)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_management!(management.id) end
    end

    test "change_management/1 returns a management changeset" do
      management = management_fixture()
      assert %Ecto.Changeset{} = Accounts.change_management(management)
    end
  end
end
