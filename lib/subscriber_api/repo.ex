defmodule SubscriberApi.Repo do
  use Ecto.Repo,
    otp_app: :subscriber_api,
    adapter: Ecto.Adapters.Postgres
end
