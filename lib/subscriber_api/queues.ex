defmodule SubscriberApi.Queues do
  alias SubscriberApi.Queues.AMQPClient

  def publish_email_subscription(message) do
    message =
      message
      |> encode()
    __MODULE__.publish(message, get_emails_queue())
  end

  def publish(message, queue) do
    %AMQPClient{} = client = AMQPClient.create()
    AMQPClient.publish(client, queue, message)
    AMQPClient.terminate(client)
  end

  defp get_emails_queue, do: "project-dev-pending_subscriptions-v1"

  defp encode(message), do: Jason.encode!(message)
end
