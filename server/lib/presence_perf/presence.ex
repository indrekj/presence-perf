defmodule PresencePerf.Presence do
  use Phoenix.Presence, otp_app: :presence_perf,
                        pubsub_server: PresencePerf.PubSub
end
