defmodule RestClient do
  alias RestClient.{Header, Request, Response}

  @spec make_request(%Request{}) :: Response.t()
  def make_request(%Request{} = request) do
    headers =
      request.headers
      |> Enum.filter(&valid_header?/1)
      |> Enum.map(fn header -> {header.key, header.value} end)

    case Mojito.request(
           request.action,
           request.location,
           headers,
           request.body
         ) do
      {:ok, response} -> Response.from_mojito(response)
      x -> x
    end
  end

  defp valid_header?(%Header{key: nil}), do: false
  defp valid_header?(%Header{key: ""}), do: false
  defp valid_header?(%Header{value: nil}), do: false
  defp valid_header?(%Header{value: ""}), do: false
  defp valid_header?(_), do: true
end
