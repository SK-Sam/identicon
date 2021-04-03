defmodule Identicon do
  @moduledoc """
    Identicon is a Github default profile icon generator. Based on string
    input, Identicon will create a 5x5 grid with colored or uncolored cells.
    Identicon will use MD5 to hash a string, and color cells with even-value
    bytes. Icons generated should be vertically symmetrical.
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
      %Identicon.Image{
        hex: [51, 37, 50, 220, 250, 161, 203, 246, 30, 42, 38, 107, 215, 35, 97, 44]
      }
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
