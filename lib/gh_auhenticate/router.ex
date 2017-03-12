defmodule GhAuthenticate.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/login" do
    conn
    |> Plug.Conn.fetch_query_params(conn)
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, login_page_content)
  end

  get "/gh-redirect" do
    conn = Plug.Conn.fetch_query_params(conn)
    IO.puts inspect conn

    token = access_token(conn)

    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, token)
  end

  match _ do send_resp(conn, 404, "oops, no page!!!") end

  def login_page_content do
  """
  <h1>My app login</h1>

  <form action="https://github.com/login/oauth/authorize" method="get">
    <input type="hidden" name="client_id" value="169d6a13fb51a4b31d67" />
    <input type="hidden" name="redirect_uri" value="https://predrag-gh-authenticate.herokuapp.com/gh-redirect" />
    <input type="hidden" name="state" value="unique_identifier" />
    <input type="submit" value="Authenticate with GitHub" />
  </form>
  """
  end

  def access_token(conn) do
    code = Map.get(conn.params, "code")

    request_path = "https://github.com/login/oauth/access_token"
    data = "client_id=169d6a13fb51a4b31d67&client_secret=d3db838f47e47b90f5486da615083fe8509a1e26&code=#{code}&state=unique_identifier"
    headers = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
    IO.puts "data: #{data}"

    {:ok, response} = HTTPoison.post(request_path, data, headers)
    IO.puts "response.code: #{response.status_code}"
    r = Map.put(response, :body, "")
    IO.puts "response: #{inspect r}"
    IO.puts "response.body: #{response.body}"
    response.body
  end


end
