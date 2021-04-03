defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input()
  end

  @doc """
    Utilizes MD5 algorithm to hash a string and return
    a List of 16 bytes.

  ## Example
      iex> Identicon.hash_input("sam")
      [51, 37, 50, 220, 250, 161, 203, 246, 30, 42, 38, 107, 215, 35, 97, 44]
  """
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end
end
