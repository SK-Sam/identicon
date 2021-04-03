defmodule Identicon do
  @moduledoc """
    Identicon is a Github default profile icon generator. Based on string
    input, Identicon will create a 5x5 grid with colored or uncolored cells.
    Identicon will use MD5 to hash a string, and color cells with even-value
    bytes. Icons generated should be vertically symmetrical.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_cells
    |> build_pixel_map
  end

  @doc """
    Utilizes MD5 algorithm to hash a string and return
    an %Identicon.Image{ hex: [List of 16 bytes] }

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

  @doc """
    Get RGB values based on byte value
  """
  def pick_color(image) do
    %Identicon.Image{hex: hex_list} = image
    [r, g, b | _tail] = hex_list

    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
    Return a grid of 25 cells(5x5)
  """
  def build_grid(image) do
    %Identicon.Image{hex: hex_list} = image
    grid =
      hex_list
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def filter_odd_cells(image) do
    %Identicon.Image{grid: grid} = image
    filtered_grid = Enum.filter(grid, fn({byte, _cell}) = _coord -> rem(byte, 2) == 0 end)

    %Identicon.Image{image | grid: filtered_grid}
  end

  def build_pixel_map(image) do
    %Identicon.Image{grid: grid} = image

   pixel_map = Enum.map grid, fn({_byte, index}) ->
      horizontal_dist = rem(index, 5) * 50
      vertical_dist = div(index, 5) * 50

      top_left = {horizontal_dist, vertical_dist}
      bottom_right = {horizontal_dist + 50, vertical_dist + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end
end
