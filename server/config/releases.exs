import Config

secret_key_base = "phoenix-perf"

config :presence_perf, PresencePerfWeb.Endpoint,
  http: [
    ip: {0,0,0,0},
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [
      max_connections: :infinity
    ]
  ],
  secret_key_base: secret_key_base

if hostnames = System.get_env("DISTRIBUTED") do
  hosts =
    hostnames
    |> String.split(",")
    |> Enum.map(&String.to_atom/1)

  config :presence_perf,
    libcluster: [
      topologies: [
        local: [
          strategy: Cluster.Strategy.Epmd,
          config: [
            hosts: hosts
          ]
        ]
      ]
    ]
end
