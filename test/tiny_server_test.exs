defmodule TinyServerTest do
  use ExUnit.Case
  doctest TinyServer

  test "greets the world" do
    assert TinyServer.hello() == :world
  end
end
