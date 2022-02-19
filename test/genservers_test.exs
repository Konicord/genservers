defmodule GenserversTest do
  use ExUnit.Case
  doctest Genservers

  test "greets the world" do
    assert Genservers.hello() == :world
  end
end
