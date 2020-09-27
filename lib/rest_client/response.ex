defmodule RestClient.Response do
  @moduledoc "This struct represents an HTTP response."

  alias RestClient.Header

  defstruct status: nil, headers: [], body: "", complete: true

  @spec from_mojito(Mojito.Response.t()) :: %__MODULE__{}
  def from_mojito(%_{status_code: status, headers: headers, body: body}) do
    headers =
      Enum.map(headers, fn {key, value} ->
        %Header{key: key, value: value, id: Ecto.UUID.generate()}
      end)

    %__MODULE__{status: status, headers: headers, body: body}
  end
end
