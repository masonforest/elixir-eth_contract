defmodule AbiTestTest do
  use ExUnit.Case
  doctest AbiTest

  test "greets the world" do
    assert AbiTest.hello() == :world
  end
end
