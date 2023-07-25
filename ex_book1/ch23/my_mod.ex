defmodule MyMod do
  def double(enumerable) do
    Enum.map(enumerable, fn n -> n * 2 end)
  end

  # def sum([]), do: 0

  def sum(list) do
    {acc, _} =
      Enum.reduce_while(list, {0, 0}, fn
        # _, {acc, 3} -> {:halt, {acc, 3}}
        0, {acc, 2} -> {:halt, {acc, 3}}
        0, {acc, count} -> {:cont, {acc, count + 1}}
        n, {acc, count} -> {:cont, {acc + n, count}}
      end)

    acc
  end
end
