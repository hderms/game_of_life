defmodule Gol do
end

defmodule Cell do
  defstruct x: nil, y: nil, live: false
  def alive?(cell) do
    !! cell.live
  end
  def proximal(numerical_coordinate) when is_integer(numerical_coordinate) do
    [numerical_coordinate, (numerical_coordinate + 1), (numerical_coordinate - 1)]

  end

end
defmodule Board do
  defstruct members: []
  def create_board({x, y}) when is_integer(x) and is_integer(y) do
    number_of_cells = x * y
    number_of_cells
    row = for x_index <- 0..x, do: %Cell{x:  x_index}
    board_array = for y_index <- 0..y do
      Enum.map(row, fn cell -> %Cell{cell | y: y_index} end)
    end
    %Board{members: List.flatten(board_array)}
  end

  def neighbors(board = %Board{}, coords) do
    neighbors(board.members, coords)
  end
  def neighbors(members, {x, y}) when is_integer(x) and is_integer(y) do
    valid_xs = Cell.proximal(x) |> Enum.reject(&(&1 < 0))
    valid_ys = Cell.proximal(y) |> Enum.reject(&(&1 < 0))
    valid_coordinates = {valid_xs, valid_ys}
    IO.puts(inspect(valid_coordinates))
    Enum.filter(members, fn cell -> 
                  neighbor?(cell, valid_coordinates, {x, y})
                  
                end  )
  end
  def neighbor?(cell, {valid_xs, valid_ys}, {x, y}) do
    cell.x in valid_xs and cell.y in valid_ys and not (cell.y == y and cell.x ==x)
  end

  def neighbors(board, cell = %Cell{x: x, y: y}) do
    neighbors(board, {x, y})
  end

  def calculate_next_state(state = %Board{}) do

  end
end
