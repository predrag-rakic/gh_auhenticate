defmodule GhAuthenticate.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/login" do
    conn
    |> Plug.Conn.fetch_query_params(conn)
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, page_content)
  end

  match _ do send_resp(conn, 404, "oops, no page!!!") end

  def page_content do
  """
  <h1>Pera i mika</h1>

  <form action="http://google.com">
    <input type="submit" value="Go to Google" />
  </form>
  """
  end


end
