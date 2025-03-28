defmodule SubscriberApi.EmailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SubscriberApi.Emails` context.
  """

  @doc """
  Generate a email_subscription.
  """
  def email_subscription_fixture(attrs \\ %{}) do
    {:ok, email_subscription} =
      attrs
      |> Enum.into(%{
        body: "some body",
        from: "some from",
        subject: "some subject",
        to: "some to"
      })
      |> SubscriberApi.Emails.create_email_subscription()

    email_subscription
  end
end
