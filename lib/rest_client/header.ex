defmodule RestClient.Header do
  @moduledoc "This struct represents an HTTP header."

  use Ecto.Schema

  embedded_schema do
    field :key, :string
    field :value, :string
  end
end
