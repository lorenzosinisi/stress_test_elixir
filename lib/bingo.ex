defmodule Bingo do
  @moduledoc """
  Documentation for `Bingo`.
  """
  def attack(url, size, every) do
    Enum.map(0..size, fn count ->
      WriteBuffer.start_link(%{url: url, every: every})
    end)
  end
end
