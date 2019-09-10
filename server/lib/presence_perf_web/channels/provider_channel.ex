defmodule PresencePerfWeb.ProviderChannel do
  use PresencePerfWeb, :channel
  alias PresencePerf.Presence

  def join("user_presence:" <> user_id, params, socket) do
    page_id = Map.fetch!(params, "page_id")
    socket =
      socket
      |> assign(:user_id, user_id)
      |> assign(:page_id, page_id)

    send(self(), :after_join)
    {:ok, socket}
  end

  # Start tracking the user but send updates to a different topic.
  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(
      socket.channel_pid,
      "page:#{socket.assigns.page_id}", # send update to this topic
      socket.assigns.user_id, # key
      %{
        joined_at: inspect(System.system_time(:second)),
        tab_id: "vcrhw97c069",
        page_description: "Glia",
        idle_timeout_seconds: 60,
        visitor_metadata: %{
          location: %{
            city: nil,
            state: nil, country: "Estonia",latitude: 59,longitude: 26,business: nil
          }
        },
        key0: "info info info info info info info info info info info info",
        key1: "info info info info info info info info info info info info",
        key2: "info info info info info info info info info info info info",
        key3: "info info info info info info info info info info info info",
        key4: "info info info info info info info info info info info info",
        key5: "info info info info info info info info info info info info",
        key6: "info info info info info info info info info info info info",
        key7: "info info info info info info info info info info info info",
        key8: "info info info info info info info info info info info info",
        key9: "info info info info info info info info info info info info"
      }
    )
    {:noreply, socket}
  end
end
