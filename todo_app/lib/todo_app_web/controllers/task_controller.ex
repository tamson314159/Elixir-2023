defmodule TodoAppWeb.TaskController do
  use TodoAppWeb, :controller

  alias TodoApp.Tasks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()

    render(conn, :index, tasks: tasks)
  end
end
