defmodule TodoAppWeb.HelloController do
  use TodoAppWeb, :controller

  def hello(conn, _params) do
    render(conn, :hello)
  end
end
