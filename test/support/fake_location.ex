defmodule RestClient.FakeLocation do
  @moduledoc "A test server so that we don't have to call ot to real servers."
  use Plug.Router

  plug :match

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  plug :dispatch

  get "/html" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "<h1>pass</h1>")
  end

  post "/json" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(conn.body_params))
  end

  get "/404" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(404, "<h1>pass</h1>")
  end
end
