defmodule JwtDemoTest do
  use ExUnit.Case
  doctest JwtDemo

  test "greets the world" do
    assert JwtDemo.hello() == :world
  end
end
