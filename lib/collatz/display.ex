defmodule Collatz.Display do
  alias Markex.Element
  import Markex.Element.Operators

  @space Element.new(" ")
  @down Element.new("|")
  @left Element.new("/")
  @right Element.new("\\")

  def format(graph) do
    format(graph, [1])
    |> Element.to_string()
  end

  defp format(graph, [num]) do
    len = length(Integer.digits(num))
    num_for_elem = Integer.to_string(num) <> if rem(len, 2) == 0 do " " else "" end

    case graph[num] do
      nil -> Element.new(num_for_elem)
      _ -> Element.new(num_for_elem) <~> @down <~> format(graph, graph[num])
    end
  end

  defp format(graph, s = [_, _]) do
    columns = Enum.map(s, fn num ->
      @down <~> format(graph, [num])
    end)

    elem = Enum.reduce(columns, fn elem, acc ->
      acc <|> @space
      |> Element.beside(elem, :top)
    end)

    connector(columns) <~> elem
  end

  def bar(symbol, len) do
    Element.new(symbol, len, 1)
  end

  defp horizontal_bar(len) do
    bar("-", len)
  end

  defp empty_bar(len) do
    bar(" ", len)
  end

  defp connector([left, right]) do
    left_column_len = left |> Element.width()
    half_left_column_len = left_column_len |> Kernel./(2) |> round()
    left_connector = empty_bar(half_left_column_len) <|> @left <|> horizontal_bar(half_left_column_len-1)

    right_column_len = right |> Element.width()
    half_right_column_len = right_column_len |> Kernel./(2) |> round()
    right_connector = horizontal_bar(half_right_column_len-1) <|> @right <|> empty_bar(half_right_column_len)

    left_connector <|> horizontal_bar(1) <|> right_connector
  end
end
