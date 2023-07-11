defmodule Hello do
  def greet do
    receive do
      {sender, name} ->
        send sender, {:ok, "Hello, #{name}"}

      # greet()
    end
  end
end

pid = spawn(Hello, :greet, [])

send pid, {self(), "Thewaggle"}

receive do
  {:ok, message} -> IO.puts message
end

send pid, {self(), "world"}

receive do
  {:ok, message} -> IO.puts message
  after 3000 -> IO.puts "Nothing happend."
end
