defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input can take in a string and return 15 numbers" do
    input = "sam"
    byte_list = [51, 37, 50, 220, 250, 161, 203, 246, 30, 42, 38, 107, 215, 35, 97, 44]

    assert Identicon.hash_input(input).hex == byte_list
    assert Enum.count(Identicon.hash_input("some random string").hex) == 16
    assert Enum.count(Identicon.hash_input(input).hex) == 16

    empty_string = ""

    assert Enum.count(Identicon.hash_input(empty_string).hex) == 16

    space_string = " "

    assert Enum.count(Identicon.hash_input(space_string).hex) == 16
  end
end
