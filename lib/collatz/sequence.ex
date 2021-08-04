defmodule Collatz.Sequence do
  @spec new(any) :: [pos_integer(), ...]
  def new(num) do
    process(num, [])
  end

  defp process(_, seq = [1 | _]) do
    seq
  end

  defp process(num, seq) when rem(num, 2) == 0 do
    process(div(num, 2), [num | seq])
  end

  defp process(num, seq) do
    process(num * 3 + 1, [num | seq])
  end
end
