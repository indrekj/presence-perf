defmodule PresencePerf.Repo do
  use Ecto.Repo,
    otp_app: :presence_perf,
    adapter: Ecto.Adapters.Postgres
end
