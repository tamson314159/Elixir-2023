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
    largest_prime_factor(n, 2)
  end

  defp largest_prime_factor(n, p) do
    cond do
      :math.sqrt(n) < p -> n
      rem(n, p) == 0 -> largest_prime_factor(div(n, p), p)
      true -> largest_prime_factor(n, p + 1)
    end
  end

  def problem004 do
    for i <- 100..999, j <- 100..999 do
      i * j
    end
    |> Enum.filter(&palindrome?/1)
    |> Enum.max()
  end

  defp palindrome?(n) do
    str_number = to_string(n)
    str_number == String.reverse(str_number)
  end

  def problem005(n \\ 20)

  def problem005(1), do: 1

  def problem005(n) do
    2..n
    |> Enum.map(&factorize(&1, [{2, 0}]))
    |> List.flatten()
    |> Enum.group_by(fn {p, _} -> p end, fn {_, x} -> x end)
    |> Map.to_list()
    |> Enum.map(fn {factor, expornets} ->
      expornet = Enum.max(expornets)
      {factor, expornet}
    end)
    |> Enum.reduce(1, fn {factor, expornent}, acc ->
      :math.pow(factor, expornent) * acc
    end)
    |> round
  end

  defp factorize(1, factors), do: factors

  defp factorize(n, [{p, 0} | tail]) do
    if rem(n, p) == 0 do
      factorize(div(n, p), [{p, 1} | tail])
    else
      factorize(n, [{p + 1, 0} | tail])
    end
  end

  defp factorize(n, [{p, x} | tail]) do
    if rem(n, p) == 0 do
      factorize(div(n, p), [{p, x + 1} | tail])
    else
      factorize(n, [{p + 1, 0}, {p, x} | tail])
    end
  end
end
