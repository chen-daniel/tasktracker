defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    if Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: page_path(conn, :dashboard))
    end
    render conn, "index.html"
  end

  def dashboard(conn, _params) do
    if !Plug.Conn.get_session(conn, :user_id) do
      redirect(conn, to: page_path(conn, :index))
    end
    tasks = Tasktracker.Tasks.list_user_tasks(conn)
    changeset = Tasktracker.Tasks.change_task(%Tasktracker.Tasks.Task{})
    render conn, "dashboard.html", tasks: tasks, changeset: changeset
  end
end
