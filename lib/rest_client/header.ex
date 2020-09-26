defmodule RestClient.Header do
  use Ecto.Schema

  embedded_schema do
    field :key, :string
    field :value, :string
  end
end
