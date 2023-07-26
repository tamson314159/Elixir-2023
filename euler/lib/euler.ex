defmodule Euler do
  def problem001(n \\ 1000) do
    1..n-1
    |> Enum.filter(fn i -> rem(i, 3) == 0 or rem(i, 5) == 0 end)
    |> Enum.sum()
  end

  @golden_ratio 1.618
  def problem002(sup \\ 4_000_000) do
    :math.log(sup) / :math.log(@golden_ratio) + 10
    |> ceil()
    |> generate_fibonacci()
    |> Enum.reverse()
    |> Enum.reduce_while(0, fn
      i, sum when i >= sup -> {:halt, sum}
      i, sum when rem(i, 2) == 0 -> {:cont, sum + i}
      _, sum -> {:cont, sum}
    end)
  end

  defp generate_fibonacci(0), do: [0]

  defp generate_fibonacci(1), do: [1, 0]

  defp generate_fibonacci(n) do
    [a, b | tail] = generate_fibonacci(n - 1)
    [a + b, a, b | tail]
  end

  def problem003(n \\ 600851475143) do

  end
end
