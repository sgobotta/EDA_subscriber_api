
publish_msg = fn ->
  {:ok, connection} = AMQP.Connection.open
  {:ok, channel} = AMQP.Channel.open(connection)

  queue = "project-dev-pending_subscriptions-v1"

  AMQP.Queue.declare(channel, queue, durable: true)

  Enum.each(1..5000, fn i -> AMQP.Basic.publish(channel, "", queue, "#{i}") end)

  AMQP.Connection.close(connection)
end
