defmodule SubscriberApiWeb.API.Emails.EmailSubscriptionJSON do
  alias SubscriberApi.Emails.EmailSubscription

  @doc """
  Renders a list of email_subscription.
  """
  def index(%{email_subscription: email_subscription}) do
    %{data: for(email_subscription <- email_subscription, do: data(email_subscription))}
  end

  @doc """
  Renders a single email_subscription.
  """
  def show(%{email_subscription: email_subscription}) do
    %{data: data(email_subscription)}
  end

  defp data(%EmailSubscription{} = email_subscription) do
    %{
      id: email_subscription.id,
      from: email_subscription.from,
      to: email_subscription.to,
      subject: email_subscription.subject,
      body: email_subscription.body
    }
  end
end
