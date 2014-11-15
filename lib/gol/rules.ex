defmodule Gol.Rules do

  @moduledoc "Rules which determine key decisions made in operation of a game of life board. "

  @proximal_length  2

  alias Gol.Cell, as: Cell
  alias Gol.Util, as: Util
  alias Gol.Coordinates, as: Coordinates

  @doc "the proximal represents the range in a given dimension which is considered a neighbor"
  def proximal(numerical_coordinate, delta \\ nil) when is_integer(numerical_coordinate) do
    delta = delta || @proximal_length
    Range.new(numerical_coordinate - delta, numerical_coordinate + delta) 
  end

  @doc "proximal range is the range in all dimensions in proximity of a given coordinate"
  def proximal_ranges(coordinates = %Coordinates{}) do
    {proximal(coordinates.x), proximal(coordinates.y)}
  end

  @doc "This rule determines the neighboring coordinates for a given coordinate"
  def neighboring_coordinates({xs, ys} = coordinate_pairs) do
    xs = xs |> proximal |> Util.iter_to_a |> Permutation.permute
    ys = ys |> proximal |> Util.iter_to_a |> Permutation.permute
    (Enum.zip(List.flatten(xs), List.flatten(Enum.reverse(ys))) |> Enum.uniq ) -- [coordinate_pairs]
  end

  @doc "Next state determines what the next state of a cell will be given a {cell, neighbor} tuple."
  def next_state({cell, neighbors}) do
    if will_live?(cell) do
      Cell.alive!(cell)
    else 
    Cell.dead!(cell)
    end
  end

  @doc "will_live? determines whether a cell will live based on its neighbor count."
  def will_live?({_, neighbors}) when neighbors <= 1 do 
    false
  end
  def will_live?({ cell, 3})  do
    true
  end
  def will_live?({ cell, 5})  do
    false
  end
  def will_live?({ cell, 5})  do
    false
  end
end

