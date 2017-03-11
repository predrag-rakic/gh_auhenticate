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

  get "/gh-redirect" do
    conn
    |> Plug.Conn.fetch_query_params(conn)
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, inspect conn)
  end

  match _ do send_resp(conn, 404, "oops, no page!!!") end

  def page_content do
  """
  <h1>Pera i mika</h1>

  <form action="https://github.com/login/oauth/authorize" method="get">
    <input type="hidden" name="client_id" value="169d6a13fb51a4b31d67" />
    <input type="hidden" name="redirect_uri" value="https://predrag-gh-authenticate.herokuapp.com/gh-redirect" />
    <input type="hidden" name="state" value="unique_identifier" />
    <input type="submit" value="Authenticate with GitHub" />
  </form>
  """
  end


end
