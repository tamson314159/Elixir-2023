defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  test "greets the world" do
    assert Euler.hello() == :world
  end
end
