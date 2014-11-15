defmodule Gol.Util do
  @moduledoc "Utility functions useful in Game of Life"

  @doc "This function converts an iterable into a list"
  def iter_to_a(iter) do
                      
    Enum.map iter, fn (x) -> x end
  end
  
end
