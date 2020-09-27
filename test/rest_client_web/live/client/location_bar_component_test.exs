defmodule RestClientWeb.Client.LocationBarComponentTest do
  @moduledoc false

  use RestClientWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Phoenix.HTML.Form
  alias RestClientWeb.Client.LocationBarComponent

  test "render" do
    form = Ecto.Changeset.change(%RestClient.Request{}, %{})
    f = Form.form_for(form, "#")

    assert render_component(LocationBarComponent, form: form, f: f) =~ "Send"
  end
end
