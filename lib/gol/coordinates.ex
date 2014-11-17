defmodule Gol.Coordinates do

  defstruct x: nil, y: nil
  alias Gol.Rules, as: Rules

  def equals?(coordinate, compared_coordinate) do
    coordinate.x == compared_coordinate.x and coordinate.y == compared_coordinate.y
  end

  def included_in_coordinate_ranges?(coordinate, {x_range = Range, y_range = Range}) do
    coordinate.x in x_range and coordinate.y in y_range
  end
end

