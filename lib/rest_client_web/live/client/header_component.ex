defmodule RestClientWeb.Client.HeaderComponent do
  use Phoenix.LiveComponent

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
        </div>
      </div>
    </div>
    """
  end
end
