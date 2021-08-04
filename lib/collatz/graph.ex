defmodule Collatz.Graph do
  @type t :: %{}

  @spec new([...]) :: t
  def new(seq) do
    %{}
    |> add(seq)
  end

  @spec add(t, [...]) :: t
  def add(graph, [_]) do
    graph
  end

  def add(graph, [n1, n2 | tail]) do

    case Map.fetch(graph, n1) do
      :error ->
        put_in(graph[n1], [n2])

      {:ok, list} ->
        if n2 not in list,
        do: put_in(graph[n1], Enum.sort([n2 | list])),
        else: graph
    end
    |> add([n2 | tail])
  end
end
