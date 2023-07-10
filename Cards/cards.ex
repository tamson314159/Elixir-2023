defmodule Cards do
  def create_deck do
    numbers = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spade", "Clover", "Diamond", "Heart"]

    for num <- numbers, suit <- suits do
      num <> "_of_" <> suit
    end
  end

  # 再帰的に作ってみた
  # def create_deck do
  #   numbers = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  #   suits = ["Spade", "Clover", "Diamond", "Heart"]

  #   create_deck(numbers, suits)
  # end

  # def create_deck([], _), do: []

  # # TODO: suits のハードコーディングをやめる
  # def create_deck([_ | tail], []), do: create_deck(tail, ["Spade", "Clover", "Diamond", "Heart"])

  # def create_deck(list, [head | tail]) do
  #   [hd(list) <> "_of_" <> head | create_deck(list, tail)]
  # end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def deal(deck, deal_size) do
    Enum.split(deck, deal_size)
  end

  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def load(file_name) do
    {status, binary} = File.read(file_name)

    if status == :error do
      "Does not exist such a file"
    else
      :erlang.binary_to_term(binary)
    end
  end
end
