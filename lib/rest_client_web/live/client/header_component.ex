defmodule RestClientWeb.Client.HeaderComponent do
  @moduledoc "The header of the page"

  use Phoenix.LiveComponent

  use Phoenix.HTML

  @spec render(map) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <div class="p-8 bg-gray-800">
      <div class="mx-auto max-w-7xl">
        <div class="md:flex md:items-center md:justify-between">
          <div class="flex-1 min-w-0">
            <h2 class="text-2xl font-bold leading-7 text-white sm:text-3xl sm:leading-9 sm:truncate">
              RestClient
            </h2>
          </div>

          <div class="flex text-gray-200">
            <a href="https://mattpruitt.com" class="mr-4">Made by Matt Pruitt</a>

            <a href="https://github.com/guitsaru/rest_client" class="flex items-center">
              <%= Phoenix.View.render RestClientWeb.IconView, "github.html", %{} %>

              <span class="ml-2">View on GitHub</span>
            </a>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
