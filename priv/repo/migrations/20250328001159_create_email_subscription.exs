defmodule SubscriberApi.Repo.Migrations.CreateEmailSubscription do
  use Ecto.Migration

  def change do
    create table(:email_subscription, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :from, :string
      add :to, :string
      add :subject, :string
      add :body, :text

      timestamps(type: :utc_datetime)
    end
  end
end
