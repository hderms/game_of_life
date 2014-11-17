defmodule Gol.Cell do

  alias __MODULE__, as: Cell
  defstruct coordinates: nil, alive: false

  def alive?(cell = %Cell{}) do
    !!cell.alive
  end

  def alive!(cell = %Cell{}) do
    %Cell{cell | alive: true}
  end

  def dead!(cell = %Cell{}) do
    %Cell{cell | alive: false}
  end

end
