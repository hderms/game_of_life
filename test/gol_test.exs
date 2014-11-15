defmodule GolTest do

  use ExUnit.Case

  alias Gol.Cell, as: Cell
  alias Gol.Board, as: Board
  alias Gol.Rules, as: Rules
  alias Gol.Coordinates, as: Coordinates

  test "Cell#alive? should be false by default" do
    cell = %Cell{}
    assert Cell.alive?(cell) == false
  end
  
  test "Cell#alive? should be true if cell is initialized with a live state" do
    cell = %Cell{alive: true}
    assert Cell.alive?(cell) == true
  end
  
  test "Cell#proximal should fail when given something that isn't an integer" do
    assert_raise FunctionClauseError, fn -> 
      Rules.proximal("h")
    end

    assert_raise FunctionClauseError, fn -> 
      Rules.proximal([])
    end
    assert_raise FunctionClauseError, fn -> 
      Rules.proximal(nil)
    end
  end
  
  test "Cell#proximal should return something which includes the numerical coordinate given " do
    coordinate = 2
    assert  coordinate in Rules.proximal(coordinate)  
  end

  test "Cell#proximal should return something which includes the numerical coordinate plus the delta given " do
    coordinate = 2
    delta = 2
    assert  coordinate + delta in Rules.proximal(coordinate, delta)  
  end
  test "Cell#alive! should turn a dead cell alive without changing coordinates" do
    cell = %Cell{alive: false}
    new_state = Cell.alive!(cell)
    assert true == Cell.alive?(new_state)
    assert cell.coordinates == new_state.coordinates
  end
  test "Cell#dead! should turn an alive cell dead without changing coordinates" do
    cell = %Cell{alive: true}
    new_state = Cell.dead!(cell)
    assert false == Cell.alive?(new_state)
    assert cell.coordinates == new_state.coordinates
  end
test "Cell#alive! should turn a live cell alive without changing coordinates" do
    cell = %Cell{alive: false}
    new_state = Cell.alive!(cell)
    assert true == Cell.alive?(new_state)
    assert cell.coordinates == new_state.coordinates
  end
  test "Cell#dead! should turn a dead cell dead without changing coordinates" do
    cell = %Cell{alive: false}
    new_state = Cell.dead!(cell)
    assert false == Cell.alive?(new_state)
    assert cell.coordinates == new_state.coordinates
  end
  
  test "Board#cell_at_coordinates? should return true if there is a cell with the same coordinates" do
    coordinates = %Coordinates{x: 1, y: 2}
    board = Board.create_board()
    board = Board.update_board(board, [%Cell{alive: true, coordinates: coordinates }]) 

    assert Board.cell_at_coordinates?(board, coordinates)

  end

  test "Board#cell_at_coordinates? should return false if there is not a cell with the same coordinates" do
    coordinates = %Coordinates{x: 2, y: 2}
    board = Board.create_board()
    board = Board.update_board(board, [%Cell{alive: true, coordinates: coordinates }]) 
    assert Board.cell_at_coordinates?(board, %Coordinates{x: 1, y: 2})
  end
  test "Board#add_candidates! must accept list" do

    Board.add_candidates!([])
    Board.add_candidates!(["foo"])
    Board.add_candidates!(["foo", "bar"])
    assert_raise FunctionClauseError, fn -> 
      Board.add_candidates!("foo")
    end
  end
  test "Board#add_candidates! will add 8 dead cells if given a single alive cell" do
    board = Board.create_board()
    board = Board.update_board(board, [%Cell{alive: true, coordinates: %Coordinates{x: 2, y: 2}}])

    assert length(Board.add_candidates!(board.living_cells)) == 9

  end

  test "Rules#neighboring_coordinates" do
    combinations = Gol.Rules.neighboring_coordinates({3, 4}) |> Enum.sort
    assert length(combinations) == 8
    assert combinations == [{2, 3}, {2, 4}, {2, 5}, {3, 3}, {3, 5}, {4, 3}, {4, 4}, {4,5}]
    
    combinations = Gol.Rules.neighboring_coordinates({0, 0}) |> Enum.sort
    assert length(combinations) == 8
    assert combinations == [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1,1}]
  end
  
  





end
