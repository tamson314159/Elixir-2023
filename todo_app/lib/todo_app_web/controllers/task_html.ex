defmodule TodoAppWeb.TaskHTML do
  use TodoAppWeb, :html

  embed_templates "task_html/*"

  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  def task_form(assigns)
end
