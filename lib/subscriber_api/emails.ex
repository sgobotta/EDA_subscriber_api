defmodule SubscriberApi.Emails do
  @moduledoc """
  The Emails context.
  """

  import Ecto.Query, warn: false
  alias SubscriberApi.Repo

  alias SubscriberApi.Emails.EmailSubscription

  @doc """
  Returns the list of email_subscription.

  ## Examples

      iex> list_email_subscription()
      [%EmailSubscription{}, ...]

  """
  def list_email_subscription do
    Repo.all(EmailSubscription)
  end

  @doc """
  Gets a single email_subscription.

  Raises `Ecto.NoResultsError` if the Email subscription does not exist.

  ## Examples

      iex> get_email_subscription!(123)
      %EmailSubscription{}

      iex> get_email_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_email_subscription!(id), do: Repo.get!(EmailSubscription, id)

  @doc """
  Creates a email_subscription.

  ## Examples

      iex> create_email_subscription(%{field: value})
      {:ok, %EmailSubscription{}}

      iex> create_email_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_email_subscription(attrs \\ %{}) do
    %EmailSubscription{}
    |> EmailSubscription.changeset(attrs)
    |> Repo.insert()
    |> on_create_email_subscription_success
  end

  defp on_create_email_subscription_success({:ok, %EmailSubscription{} = subscription} = response) do
    SubscriberApi.Queues.publish_email_subscription(subscription)
    response
  end

  defp on_create_email_subscription_success({:error, %Ecto.Changeset{}}= error), do: error

  @doc """
  Updates a email_subscription.

  ## Examples

      iex> update_email_subscription(email_subscription, %{field: new_value})
      {:ok, %EmailSubscription{}}

      iex> update_email_subscription(email_subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_email_subscription(%EmailSubscription{} = email_subscription, attrs) do
    email_subscription
    |> EmailSubscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a email_subscription.

  ## Examples

      iex> delete_email_subscription(email_subscription)
      {:ok, %EmailSubscription{}}

      iex> delete_email_subscription(email_subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_email_subscription(%EmailSubscription{} = email_subscription) do
    Repo.delete(email_subscription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking email_subscription changes.

  ## Examples

      iex> change_email_subscription(email_subscription)
      %Ecto.Changeset{data: %EmailSubscription{}}

  """
  def change_email_subscription(%EmailSubscription{} = email_subscription, attrs \\ %{}) do
    EmailSubscription.changeset(email_subscription, attrs)
  end
end
