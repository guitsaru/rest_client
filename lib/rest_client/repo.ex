defmodule RestClient.Repo do
  use Ecto.Repo,
    otp_app: :rest_client,
    adapter: Ecto.Adapters.Postgres
end
