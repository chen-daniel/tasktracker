defmodule Tasktracker.TasksTest do
  use Tasktracker.DataCase

  alias Tasktracker.Tasks

  describe "tasks" do
    alias Tasktracker.Tasks.Task

    @valid_attrs %{completed: true, created_by: "some created_by", description: "some description", time: ~N[2010-04-17 14:00:00.000000], title: "some title"}
    @update_attrs %{completed: false, created_by: "some updated created_by", description: "some updated description", time: ~N[2011-05-18 15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{completed: nil, created_by: nil, description: nil, time: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.completed == true
      assert task.created_by == "some created_by"
      assert task.description == "some description"
      assert task.time == ~N[2010-04-17 14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Tasks.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.created_by == "some updated created_by"
      assert task.description == "some updated description"
      assert task.time == ~N[2011-05-18 15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
