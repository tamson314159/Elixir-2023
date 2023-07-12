defmodule Day3Work do
  def question01(s \\ "stressed") do
    String.reverse(s)
    |> IO.puts()
  end

  def question02() do
    s = "パタトクカシーー"

    String.codepoints(s)
    |> Enum.with_index()
    |> Enum.filter(fn {_char, index} -> rem(index, 2) == 0 end)
    |> Enum.map(fn {char, _index} -> char end)
    |> Enum.join()
    |> IO.puts()
  end

  def question03() do
    s1 = "パトカー"
    s2 = "タクシー"

    s1 = String.graphemes(s1)
    s2 = String.graphemes(s2)

    Enum.zip(s1, s2)
    |> Enum.map(fn {c1, c2} -> c1 <> c2 end)
    |> Enum.join()
    |> IO.puts()
  end

  def question04() do
    s = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."

    String.replace(s, [",", "."], "")
    |> String.split(" ")
    |> Enum.map(fn s -> String.length(s) end)
    |> IO.inspect()
    :ok
  end

  def question05() do
    s = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
    n = [1, 5, 6, 7, 8, 9, 15, 16, 19]

    String.replace(s, ".", "")
    |> String.split(" ")
    |> Enum.with_index(1)
    # |> Enum.map(fn {word, num} -> %{get_symbol(word, num, n) => num} end)
    |> Enum.map(fn {word, num} -> get_symbol(word, num, n) end)
    |> IO.inspect()

    :ok
  end

  # defp get_symbol(word, num, n) do
  #   if num in n do
  #     String.at(word, 0)
  #   else
  #     String.at(word, 0) <> String.at(word, 1)
  #   end
  # end

  defp get_symbol(word, num, n) do
    if num in n do
      %{String.at(word, 0) => num}
    else
      %{String.at(word, 0) <> String.at(word, 1) => num}
    end
  end

  def question06() do
    s = "I am an NLPer"

    IO.puts("単語")
    String.split(s, " ")
    |> bi_gram()
    |> IO.inspect()

    IO.puts("文字")
    # String.graphemes(s)
    String.codepoints(s)
    |> bi_gram()
    |> IO.inspect()

    :ok
  end

  # defp bi_gram([_]), do: []

  # defp bi_gram([head1, head2 | tail]) do
  #   [{head1, head2} | bi_gram([head2 | tail])]
  # end

  defp bi_gram(list) do
    [_ | tail] = list
    Enum.zip(list, tail)
  end

  def question07() do
  end
end
