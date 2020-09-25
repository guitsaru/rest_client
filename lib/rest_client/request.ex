defmodule RestClient.Request do
  use Ecto.Schema

  defmodule Header do
    use Ecto.Schema

    embedded_schema do
      field :key, :string
      field :value, :string
    end
  end

  @primary_key false
  embedded_schema do
    field :action, :string
    field :location, :string
    field :body, :string

    embeds_many :headers, __MODULE__.Header
  end
end
