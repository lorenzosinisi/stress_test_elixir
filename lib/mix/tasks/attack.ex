defmodule Mix.Tasks.Attack do
  use Mix.Task

  def run(args) do
    Mix.Task.run("app.start")

    case OptionParser.parse(args, switches: [url: :string, count: :number, every: :number]) do
      {[url: url, count: count, every: every], [], []} ->
        Bingo.attack(url, Integer.parse(count) |> elem(0), Integer.parse(every) |> elem(0))

        :timer.sleep(:infinity)

      opts ->
        IO.inspect("bad options #{inspect(opts)}")
        :application.stop(:normal)
    end
  end
end
