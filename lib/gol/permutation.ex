defmodule Permutation do

  def permute(list) do
    [head | tail] = list
    insert_element(head, tail)
  end

  def insert_element(el, []), do: [[el]]
  def insert_element(el, list) do
    [head | tail] = list
    permuted = insert_element(head, tail)
    Enum.flat_map(permuted, fn(current_list) ->
      Enum.map((0..length(current_list)), &(List.insert_at(current_list,&1,el)))
    end)
  end

end
