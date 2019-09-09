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
        joined_at: inspect(System.system_time(:second))
      }
    )
    {:noreply, socket}
  end
end
