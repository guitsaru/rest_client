defmodule RestClient do
  alias RestClient.Request

  @spec make_request(%Request{}) :: Mojito.Response.t()
  def make_request(%Request{} = request) do
    case Mojito.request(
           request.action,
           request.location,
           Enum.map(request.headers, fn header -> {header.key, header.value} end),
           request.body
         ) do
      {:ok, response} -> response
      _ -> {:ok, %{}}
    end
  end
end
