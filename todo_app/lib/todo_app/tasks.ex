defmodule TodoApp.Tasks do
  alias TodoApp.Repo
  alias TodoApp.Tasks.Task

  def list_tasks(), do: Repo.all(Task)
end
