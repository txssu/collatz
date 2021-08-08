defmodule Collatz.Convert do
  def nums_to_bintree(nums) do
    nums
    |> Stream.map(&add_path/1)
    |> Enum.reduce(Bintree.new(1), &insert_all/2)
  end

  defp add_path([_one | seq]) do
    seq
    |> Enum.reduce({[], []}, fn elem, {nums, path} ->
       turn = if rem(elem, 2) == 0 do
         :left
       else
         :right
       end
       path = [turn | path]
       {[{elem, path} | nums], path}
    end)
    |> elem(0)
    |> Stream.map(fn {num, path} -> {num, Enum.reverse(path)} end)
    |> Enum.reverse()
  end

  defp insert_all(seq, tree) do
    seq
    |> Enum.reduce(tree, fn {num, path}, acc ->
      Bintree.insert(acc, path, num)
    end)
  end
end
