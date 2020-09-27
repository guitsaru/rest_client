defmodule RestClientWeb.ClientLiveTest do
  @moduledoc false

  use RestClientWeb.ConnCase

  import Phoenix.LiveViewTest

  setup do
    options = [
      scheme: :http,
      plug: RestClient.FakeLocation,
      options: [port: 4004]
    ]

    start_supervised!({Plug.Cowboy, options})
    :ok
  end

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "RestClient"
    assert render(page_live) =~ "RestClient"
  end

  test "add response headers", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    assert view
           |> element("#request-component .tab.inactive", "Headers")
           |> render_click() =~ "Add Header"

    assert view
           |> element("#request-component a", "Add Header")
           |> render_click() =~ "placeholder=\"Key\""
  end

  test "delete response headers", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    view
    |> element("#request-component .tab.inactive", "Headers")
    |> render_click() =~ "Add Header"

    view
    |> element("#request-component a", "Add Header")
    |> render_click() =~ "placeholder=\"Key\""

    refute view
           |> element("#request-component a", "delete")
           |> render_click() =~ "placeholder=\"Key\""
  end

  test "send url", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    assert view
           |> form("form", request: %{"location" => "http://localhost:4004/html"})
           |> render_submit() =~ "200\n</span>"
  end

  test "view response headers", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    form = form(view, "form", request: %{"location" => "http://localhost:4004/html"})
    render_submit(form)

    assert view
           |> element("#response-component .tab.inactive", "Headers")
           |> render_click() =~ "content-type"
  end

  test "back to request body", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    assert view
           |> element("#request-component .tab.inactive", "Headers")
           |> render_click() =~ "Add Header"

    assert view
           |> element("#request-component .tab.inactive", "Body")
           |> render_click() =~ "id=\"request_body\""
  end

  test "back to response body", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    form = form(view, "form", request: %{"location" => "http://localhost:4004/html"})
    render_submit(form)

    assert view
           |> element("#response-component .tab.inactive", "Headers")
           |> render_click() =~ "text/html"

    assert view
           |> element("#response-component .tab.inactive", "Body")
           |> render_click() =~ "id=\"response-body\""
  end
end
