defmodule Gol.Board do

  defstruct  living_cells: []

  alias Gol.Cell, as: Cell
  alias Gol.Rules, as: Rules
  alias Gol.Coordinates, as: Coordinates
  alias __MODULE__, as: Board

  @doc "Creates a board. This is the normal way for a board to be created."
  def create_board() do
    %Board{}
  end

  @doc "Update a board to add more cells to it."
  def update_board(board, cells) do
    living_cells = board.living_cells
    %Board{board| living_cells: cells ++ living_cells }

  end
  
  @doc "Determines the living cells neighboring a set of coordinates."
  def living_neighbors(board = %Board{}, coords) do
    living_neighbors(board.cells, coords)
  end
  def living_neighbors(cells,  coordinates = %Coordinates{}) do
   valid_coordinates = Rules.proximal_ranges(coordinates)
   Enum.filter(cells, fn cell -> 
                  neighbor?(cell, valid_coordinates) and !Coordinates.equals?(cell.coordinates, coordinates )
                end  )
  end
  def living_neighbors(board, cell = %Cell{}) do
    living_neighbors(board, cell.coordinates)
  end

  @doc "Answers the question of whether a cell exists already at the given coordinates."
  def cell_at_coordinates?(board, coordinates = %Coordinates{}) do
    Enum.filter(board.living_cells, fn cell -> 
                  Coordinates.equals?(cell.coordinates, coordinates) 
                end)
  end
  
  @doc "Candidate cells are cells which are currently dead but which are candidates for coming to life."
  def add_candidates!( cells  ) when is_list(cells) do
    Enum.map(cells, fn element -> 

             end) |> Enum.uniq
  end

  def neighbor?(cell, {valid_xs, valid_ys}) do

    Coordinates.included_in_coordinate_ranges?(cell.coordinates, {valid_xs, valid_ys})
  end

  def calculate_next_state(state = %Board{}) do

  end

end
