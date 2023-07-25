defmodule Euler do
  def problem001(n \\ 1000) do
    1..n-1
    |> Enum.filter(fn i -> rem(i, 3) == 0 or rem(i, 5) == 0 end)
    |> Enum.sum()
  end
end
