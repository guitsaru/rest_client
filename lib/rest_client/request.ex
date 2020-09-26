defmodule RestClient.Request do
  use Ecto.Schema

  alias RestClient.Header

  @primary_key false
  embedded_schema do
    field :action, :string
    field :location, :string
    field :body, :string
    field :complete, :boolean, default: false

    embeds_many :headers, Header
  end
end
