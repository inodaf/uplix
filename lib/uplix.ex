defmodule Uplix do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Uplix.Plug, [])
    ]

    opts = [strategy: :one_for_one, name: Uplix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
