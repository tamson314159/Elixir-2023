defmodule Console do
  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(state) do
    Process.send(__MODULE__, :process_command, [])
    {:ok, state}
  end

  def handle_info(:process_command, state) do
    command =
      "COMMAND> "
      |> IO.gets()
      |> String.trim()

    case command do
      "rand " <> arg -> exec_rand(arg)
      "echo" -> exec_echo("")
      "echo " <> args -> exec_echo(args)
      "sum " <> args -> exec_sum(args)
      "exit" -> System.halt(0)
      _ -> IO.puts("UNKOWN COMMAND")
    end

    Process.send(__MODULE__, :process_command, [])
    {:noreply, state}
  end

  defp exec_rand(arg) do
    case Integer.parse(arg) do
      {n, ""} -> IO.puts(:rand.uniform(n))
      _ -> IO.puts("ERROR")
    end
  end

  defp exec_echo(args) do
    args
    |> String.split()
    |> Enum.join(" ")
    |> IO.puts()
  end

  defp exec_sum(args) do
    numbers =
      args
      |> String.split()
      |> Enum.map(&Integer.parse(&1))

    if Enum.all?(numbers, fn number -> match?({_, ""}, number) end) do
      numbers
      |> Enum.map(fn {n, _} -> n end)
      |> Enum.sum()
      |> IO.puts()
    else
      IO.puts("ERROR")
    end
  end
end

Console.start_link(nil)
