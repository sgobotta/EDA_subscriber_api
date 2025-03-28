defmodule SubscriberApi.Queues.AMQPClient do
  defstruct connection: nil, channel: nil

  def create do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)
    %__MODULE__{connection: connection, channel: channel}
  end

  def publish(%__MODULE__{channel: channel}, queue, message) do
    AMQP.Basic.publish(channel, "", queue, message)
  end

  def terminate(%__MODULE__{connection: connection}) do
    AMQP.Connection.close(connection)
  end
end
