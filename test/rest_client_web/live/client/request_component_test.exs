defmodule RestClientWeb.Client.RequestComponentTest do
  @moduledoc false

  use RestClientWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Phoenix.HTML.Form
  alias RestClientWeb.Client.RequestComponent

  test "render" do
    object = %RestClient.Request{}
    form = Ecto.Changeset.change(object, %{})
    f = Form.form_for(form, "#")

    assert render_component(RequestComponent, id: "test component", object: object, f: f) =~
             "Test component"
  end

  describe "status_tag/1" do
    test "100 status" do
      assert {:safe, html} = RequestComponent.status_badge(101)
      assert html =~ "bg-blue-100"
    end

    test "200 status" do
      assert {:safe, html} = RequestComponent.status_badge(201)
      assert html =~ "bg-green-100"
    end

    test "300 status" do
      assert {:safe, html} = RequestComponent.status_badge(301)
      assert html =~ "bg-gray-100"
    end

    test "400 status" do
      assert {:safe, html} = RequestComponent.status_badge(401)
      assert html =~ "bg-yellow-100"
    end

    test "500 status" do
      assert {:safe, html} = RequestComponent.status_badge(501)
      assert html =~ "bg-red-100"
    end
  end
end
