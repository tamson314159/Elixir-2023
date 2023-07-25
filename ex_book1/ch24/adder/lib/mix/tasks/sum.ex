defmodule Mix.Tasks.Sum do
  @shortdoc "Sum up the given number"

  use Mix.Task

  def run(args) do
    args
    |> Adder.get_total()
    |> IO.puts()
  end
end
