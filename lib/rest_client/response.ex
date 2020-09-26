defmodule RestClient.Response do
  defstruct status: nil, headers: [], body: "", complete: true

  @spec from_mojito(Mojito.Response.t()) :: %__MODULE__{}
  def from_mojito(%_{status_code: status, headers: headers, body: body}) do
    %__MODULE__{status: status, headers: headers, body: body}
  end
end
