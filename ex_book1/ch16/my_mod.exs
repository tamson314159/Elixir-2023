defmodule MyMod do
  def double({a, b, c}) do
    {a * 2, b * 2, c * 2}
  end
end

{1, 2, 3} |> MyMod.double() |> IO.inspect()
