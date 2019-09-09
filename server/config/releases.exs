import Config

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
