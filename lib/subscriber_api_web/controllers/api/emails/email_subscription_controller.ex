defmodule SubscriberApiWeb.API.Emails.EmailSubscriptionController do
  use SubscriberApiWeb, :controller

  alias SubscriberApi.Emails
  alias SubscriberApi.Emails.EmailSubscription

  action_fallback SubscriberApiWeb.FallbackController

  def index(conn, _params) do
    email_subscription = Emails.list_email_subscription()
    render(conn, :index, email_subscription: email_subscription)
  end

  def create(conn, %{"email_subscription" => email_subscription_params}) do
    with {:ok, %EmailSubscription{} = email_subscription} <- Emails.create_email_subscription(email_subscription_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/emails/#{email_subscription}")
      |> render(:show, email_subscription: email_subscription)
    end
  end

  def show(conn, %{"id" => id}) do
    email_subscription = Emails.get_email_subscription!(id)
    render(conn, :show, email_subscription: email_subscription)
  end

  def update(conn, %{"id" => id, "email_subscription" => email_subscription_params}) do
    email_subscription = Emails.get_email_subscription!(id)

    with {:ok, %EmailSubscription{} = email_subscription} <- Emails.update_email_subscription(email_subscription, email_subscription_params) do
      render(conn, :show, email_subscription: email_subscription)
    end
  end

  def delete(conn, %{"id" => id}) do
    email_subscription = Emails.get_email_subscription!(id)

    with {:ok, %EmailSubscription{}} <- Emails.delete_email_subscription(email_subscription) do
      send_resp(conn, :no_content, "")
    end
  end
end
