defmodule WordCountDist do
  use Application

  alias WordCountDist.{Manager, Worker}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    #
    # The `erl_boot_server` is added to the supervisor hierarchy to
    # ensure that it remains functional.
    #
    children = [
      worker(:erl_boot_server, [[]]),
      worker(Manager, [])
    ]

    opts = [strategy: :one_for_one, name: WordCountDist.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
