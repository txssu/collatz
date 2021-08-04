defmodule Collatz.Element do
  @type t :: list(String.t())

  @spec new(String.t()) :: t
  def new(content) when is_binary(content) do
    [content]
  end

  @spec new(list(String.t())) :: t
  def new(content) when is_list(content)  do
    width = Enum.reduce(content, 0, &max(String.length(&1), &2))
    Enum.map(content, &String.pad_trailing(&1, width))
  end

  @spec new(String.t(), non_neg_integer(), non_neg_integer()) :: t
  def new(ch, w, h) do
    ch
    |> String.duplicate(w)
    |> List.duplicate(h)
  end

  @spec make_string(t) :: String.t()
  def make_string(elem) do
    Enum.join(elem, "\n")
  end

  @spec height(t) :: non_neg_integer()
  def height(elem) do
    length(elem)
  end

  @spec width(t) :: non_neg_integer()
  def width(elem) do
    if height(elem) != 0 do
      String.length(List.first(elem))
    else
      0
    end
  end

  @spec wider(t, pos_integer()) :: t
  def wider(elem, n) do
    add_space = n - width(elem)
    left = Integer.floor_div(add_space, 2)

    elem
    |> Enum.map(&String.pad_leading(&1, width(elem) + left))
    |> Enum.map(&String.pad_trailing(&1, n))
  end

  @spec higher(t, pos_integer(), :default | :bottom) :: t
  def higher(elem, n, mode \\ :default)

  def higher(elem, n, mode) when mode == :default do
    add_space = n - height(elem)
    up = Integer.floor_div(add_space, 2)
    down = add_space - up

    blank = String.duplicate(" ", width(elem))

    List.duplicate(blank, up)
    |> Enum.concat(elem)
    |> Enum.concat(List.duplicate(blank, down))
  end

  @spec higher(t, pos_integer()) :: t
  def higher(elem, n, mode) when mode == :bottom do
    add_space = n - height(elem)

    blank = String.duplicate(" ", width(elem))

    elem
    |> Enum.concat(List.duplicate(blank, add_space))
  end

  @spec over(t, t) :: t
  def over(this, that) do
    w = max(width(this), width(that))
    this = wider(this, w)
    that = wider(that, w)
    Enum.concat(this, that)
  end

  @spec beside(t, t) :: t
  def beside(this, that) do
    h = max(height(this), height(that))
    this = higher(this, h)
    that = higher(that, h)

    Enum.zip(this, that)
    |> Enum.map(fn {l1, l2} -> l1 <> l2 end)
  end

  def beside(this, that, mode) do
    h = max(height(this), height(that))
    this = higher(this, h, mode)
    that = higher(that, h, mode)

    Enum.zip(this, that)
    |> Enum.map(fn {l1, l2} -> l1 <> l2 end)
  end
end
