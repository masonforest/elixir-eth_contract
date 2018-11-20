defmodule AbiTest do
  @moduledoc """
  Documentation for AbiTest.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AbiTest.hello()
      :world

  """
  def hello do
    IO.inspect SimpleStorage.get()

    :world
  end

end
