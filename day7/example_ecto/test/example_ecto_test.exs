defmodule ExampleEctoTest do
  use ExUnit.Case
  doctest ExampleEcto

  test "greets the world" do
    assert ExampleEcto.hello() == :world
  end
end
