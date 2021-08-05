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

  defp parse(_) do
    :error
  end

  defp process(:error) do
    "Usage: ./collatz to <num>"
  end

  defp process({:to, num}) do
    1..num
    |> Stream.map(&Collatz.Sequence.new/1)
    |> Enum.reduce(%{}, &Collatz.Graph.add(&2, &1))
    |> Collatz.Display.format()
  end
end
