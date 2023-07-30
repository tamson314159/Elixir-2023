defmodule Link1 do
  import :timer, only: [sleep: 1]

  def dead_function do
    sleep 500
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link1, :dead_function, [])

    receive do
      msg ->
        IO.puts "Message receive: #{inspect msg}"

      after 1000 ->
        IO.puts "Nothing happend"
    end
  end
end

Link1.run()
