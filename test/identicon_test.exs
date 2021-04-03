defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input can take in a string and return 15 numbers" do
    input = "sam"
    byte_list = [51, 37, 50, 220, 250, 161, 203, 246, 30, 42, 38, 107, 215, 35, 97, 44]

    assert Identicon.hash_input(input) == byte_list
    assert Enum.count(Identicon.hash_input("some random string")) == 16
    assert Enum.count(Identicon.hash_input(input)) == 16
  end
end
