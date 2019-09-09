defmodule PresencePerfWeb.PageController do
  use PresencePerfWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def online_user_count(conn, %{"page_id" => page_id} = _params) do
    list = PresencePerf.Presence.list("page:#{page_id}")
    count = length(Map.keys(list))

    send_resp(conn, 200, "count: #{count}")
  end
end
