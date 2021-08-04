defmodule Collatz.Element.Operators do
  import Collatz.Element

  def top <~> bottom do
    over(top, bottom)
  end

  def left <|> right do
    beside(left, right)
  end
end
