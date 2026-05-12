defmodule TinyServer.CallbackModule do
  def init(:ignore) do
    :ignore
  end

  def init(to_sleep) when is_integer(to_sleep) do
    Process.sleep(to_sleep)
    IO.puts("Done")
    {:error, :slept}
  end

  def init(args) do
    {:ok, args}
  end
end
