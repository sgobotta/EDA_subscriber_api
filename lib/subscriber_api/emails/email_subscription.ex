defmodule SubscriberApi.Emails.EmailSubscription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:body, :to, :from, :subject]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "email_subscription" do
    field :body, :string
    field :to, :string
    field :from, :string
    field :subject, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(email_subscription, attrs) do
    email_subscription
    |> cast(attrs, [:from, :to, :subject, :body])
    |> validate_required([:from, :to, :subject, :body])
  end
end
