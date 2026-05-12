defmodule TinyServer do
  def start_link(module, args, opts \\ []) do
    pid = spawn(fn ->
      loop()
    end)

    {:ok, pid}
  end

  defp loop(state) do
    receive do
      {:message_type, value} ->
        # code
    end

    loop(state)
  end
  def call do

  end

  def cast do

  end

  def stop do

  end
end
