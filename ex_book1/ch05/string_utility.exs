defmodule StringUrility do
  def add_parens(str) do
    "(#{str})"
  end
end

x = "elixir"
y = StringUrility.add_parens(x)
IO.puts(y)
