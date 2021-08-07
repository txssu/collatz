defmodule Collatz.CLI do
  # ./collatz to 13
  #
  def main(argv) do
    argv
    |> parse()
    |> process()
    |> IO.puts()
  end

  defp parse(["to", value]) do
    with {num, _} <- Integer.parse(value) do
      {:to, num}
    else
      e -> e
    end
  end

  defp parse(["for" | values]) do
    nums =
      Enum.map(values, fn value ->
        with {num, _} <- Integer.parse(value) do
          num
        else
          e -> e
        end
      end)

    if Enum.all?(nums, &(&1 != :error)) do
      {:for, nums}
    else
      :error
    end
  end

  defp parse(["depth", value]) do
    with {num, _} <- Integer.parse(value) do
      {:depth, num}
    else
      e -> e
    end
  end

  defp parse(_) do
    :error
  end

  defp process(:error) do
    ~s"""
    Usage:
        collatz to <num> - crete graph for numbers from 1 to 'num'
        collatz for <num1> <num2> ... - create graph for given nums\
    """
  end

  defp process({:to, num}) do
    process({:for, 1..num})
  end

  defp process({:for, nums}) do
    nums
    |> Stream.map(&Collatz.Sequence.new/1)
    |> Enum.reduce(%{}, &Collatz.Graph.add(&2, &1))
    |> Collatz.Display.format()
  end

  defp process({:depth, num}) do
    right_fun = fn value ->
      value = value - 1
      if rem(value, 3) == 0 do
        div(value, 3)
      else
        0
      end
    end

    Bintree.new(1, &(&1 * 2), right_fun, num)
    |> Bintree.filter(&(&1 != 0))
    |> Bintree.Utils.remove_duplicates()
    |> Bintree.to_string()
  end
end
