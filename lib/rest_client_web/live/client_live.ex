defmodule RestClientWeb.ClientLive do
  use Phoenix.LiveView, container: {:div, class: "min-h-screen flex flex-col"}
  use Phoenix.HTML

  import Ecto.Changeset

  alias RestClient.{Request, Response}

  alias RestClientWeb.Client.{
    HeaderComponent,
    LocationBarComponent,
    RequestComponent
  }

  @impl true
  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <%= live_component @socket, HeaderComponent %>

    <%= f = form_for(@form, "#", [phx_change: :validate, phx_submit: :send, class: "block relative flex-auto"]) %>

      <div class="absolute inset-0 flex flex-col">
        <%= live_component @socket, LocationBarComponent, form: assigns[:form], f: f %>

        <div class="grid flex-auto grid-cols-2 p-6">
          <%= live_component @socket, RequestComponent, id: "request", f: f, object: assigns[:request] %>
          <%= live_component @socket, RequestComponent, id: "response", f: f, object: assigns[:response] %>
        </div>
      </div>
    </form>
    """
  end

  @impl true
  @spec mount(map, map, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    request = %Request{}
    form = change(request, %{})

    socket =
      socket
      |> assign(:request, request)
      |> assign(:form, form)
      |> assign(:response, %Response{})

    {:ok, socket}
  end

  @impl true
  @spec handle_event(any, map, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("send", %{"request" => attributes}, socket) do
    changeset = cast(socket.assigns.request, attributes, [:action, :location, :body])
    request = apply_changes(changeset)

    response = RestClient.make_request(request)

    socket =
      socket
      |> assign(:response, response)
      |> assign(:form, changeset)

    {:noreply, socket}
  end

  def handle_event("validate", %{"request" => attributes}, socket) do
    changeset =
      socket.assigns.request
      |> cast(attributes, [:action, :location, :body])
      |> validate_required([:action, :location])
      |> cast_embed(:headers, with: &headers_changeset/2)

    request = apply_changes(changeset)

    socket =
      socket
      |> assign(:request, request)
      |> assign(:form, changeset)

    {:noreply, socket}
  end

  def handle_event("add_header", _, socket) do
    request = socket.assigns.request
    headers = request.headers ++ [%RestClient.Header{id: Ecto.UUID.generate()}]
    request = %{request | headers: headers}
    form = change(request, %{})

    socket =
      socket
      |> assign(:request, request)
      |> assign(:form, form)

    {:noreply, socket}
  end

  def handle_event("delete_header", %{"id" => id}, socket) do
    request = socket.assigns.request
    headers = Enum.filter(request.headers, fn h -> h.id != id end)
    request = %{request | headers: headers}
    form = change(request, %{})

    socket =
      socket
      |> assign(:request, request)
      |> assign(:form, form)

    {:noreply, socket}
  end

  defp headers_changeset(header, attributes) do
    cast(header, attributes, [:id, :key, :value])
  end
end
