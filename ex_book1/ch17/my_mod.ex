defmodule MyMod do
  def triple_each(list), do: Enum.map(list, fn x -> x * 3 end)
end
