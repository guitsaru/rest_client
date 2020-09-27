defmodule RestClient.RestClientTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias RestClient.Request

  setup do
    options = [
      scheme: :http,
      plug: RestClient.FakeLocation,
      options: [port: 4004]
    ]

    start_supervised!({Plug.Cowboy, options})
    :ok
  end

  describe "make_request/1" do
    test "GET /html" do
      request = %Request{action: :get, location: "http://localhost:4004/html"}
      assert response = RestClient.make_request(request)
      assert response.status == 200
      assert response.body == "<h1>pass</h1>"

      assert %_{key: "content-type", value: "text/html; charset=utf-8"} =
               Enum.find(response.headers, fn h -> h.key == "content-type" end)
    end

    test "GET /html with empty headers" do
      request = %Request{
        action: :get,
        location: "http://localhost:4004/html",
        headers: [%RestClient.Header{}]
      }

      assert response = RestClient.make_request(request)
      assert response.status == 200
      assert response.body == "<h1>pass</h1>"
    end

    test "POST /json" do
      request = %Request{
        action: :post,
        location: "http://localhost:4004/json",
        body: "{\"input\": \"pass\"}",
        headers: [%RestClient.Header{key: "content-type", value: "application/json"}]
      }

      assert response = RestClient.make_request(request)
      assert response.status == 200
      assert response.body == "{\"input\":\"pass\"}"

      assert %_{key: "content-type", value: "application/json; charset=utf-8"} =
               Enum.find(response.headers, fn h -> h.key == "content-type" end)
    end

    test "GET /404" do
      request = %Request{action: :get, location: "http://localhost:4004/404"}
      assert response = RestClient.make_request(request)
      assert response.status == 404
      assert response.body == "<h1>pass</h1>"
    end

    test "an invalid url" do
      request = %Request{action: :get, location: "localhost:4004/html"}
      assert response = RestClient.make_request(request)

      assert %_{body: "invalid URL: localhost:4004/html", status: 400} = response
    end
  end
end
