defmodule TinyServer do
  def start_link(module, args, opts \\ []) do
    parent = self()
    ref = make_ref()
    pid = spawn_link(fn -> run(module, args, parent, ref) end)

    timeout = Keyword.get(opts, :timeout, :timer.seconds(5))

    receive do
      {^ref, :initialized} ->
        {:ok, pid}

      {^ref, init_result} ->
        init_result
    after
      timeout ->
        IO.puts("unlink first...")
        Process.unlink(pid)
        IO.puts("then kill the pid #{inspect(pid)} ...")
        Process.exit(pid, :kill)
        {:error, :timeout}
    end
  end

  defp run(module, args, parent, ref) do
    case module.init(args) do
      {:ok, state} ->
        send(parent, {ref, :initialized})
        loop(module, state)

      other -> # {:error, reason} | :ignore
        send(parent, {ref, other})
    end
  end

  defp loop(module, state) do
    new_state = receive do
      message ->
        IO.inspect("Tiny server got " <> inspect(message))
        state
    end

    loop(module, new_state)
  end

  def call do
  end

  def cast do
  end

  def stop do
  end
end
