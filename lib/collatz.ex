defmodule Collatz do
  def main([arg | []]) do
    1..(String.to_integer(arg))
    |> Stream.map(&Collatz.Sequence.new/1)
    |> Enum.reduce(%{}, &Collatz.Graph.add(&2, &1))
    |> Collatz.Display.format()
    |> IO.puts()
  end
end
