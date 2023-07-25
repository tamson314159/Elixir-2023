defmodule Auth do
  def permitted?(tuple) do
    case tuple do
      # tuple when Enum.at(tuple, 1) == "test" -> true
      t when elem(t, 1) == "test" -> true
      {:admin, _} -> true
      {:member, _, rank} when rank in [:platinum, :gold] -> true
      {:member, _, _} -> false
      {:guest, _} -> false
    end
  end
end

users = [
  {:admin, "alice"},
  {:member, "bod", :gold},
  {:member, "carol", :silver},
  {:guest, "david"}
]

users
|> Enum.map(fn user -> Auth.permitted?(user) end)
|> IO.inspect()
