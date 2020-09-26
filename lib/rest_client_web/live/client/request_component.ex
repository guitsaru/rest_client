defmodule RestClientWeb.Client.RequestComponent do
  use Phoenix.HTML
  use Phoenix.LiveComponent

  @impl Phoenix.LiveComponent
  @spec mount(Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(socket) do
    {:ok, assign(socket, :current_tab, "body")}
  end

  @impl Phoenix.LiveComponent
  @spec handle_event(any, map(), Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("set_current_tab", %{"name" => name}, socket) do
    {:noreply, assign(socket, :current_tab, name)}
  end

  @spec status_badge(integer()) :: {:safe, String.t()}
  def status_badge(status) do
    # bg-blue-100 text-blue-800
    # bg-green-100 text-green-800
    # bg-gray-100 text-gray-800
    # bg-yellow-100 text-yellow-800
    # bg-red-100 text-red-800

    color = status_color(status)

    html = """
    <span class="inline-flex items-center px-3 py-0.5 rounded-full text-sm font-medium leading-5 bg-#{
      color
    }-100 text-#{color}-800">
      #{status}
    </span>
    """

    {:safe, html}
  end

  defp status_color(status) when status < 200, do: "blue"
  defp status_color(status) when status < 300, do: "green"
  defp status_color(status) when status < 400, do: "gray"
  defp status_color(status) when status < 500, do: "yellow"
  defp status_color(_), do: "red"
end
