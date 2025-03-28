defmodule SubscriberApi.EmailsTest do
  use SubscriberApi.DataCase

  alias SubscriberApi.Emails

  describe "email_subscription" do
    alias SubscriberApi.Emails.EmailSubscription

    import SubscriberApi.EmailsFixtures

    @invalid_attrs %{body: nil, to: nil, from: nil, subject: nil}

    test "list_email_subscription/0 returns all email_subscription" do
      email_subscription = email_subscription_fixture()
      assert Emails.list_email_subscription() == [email_subscription]
    end

    test "get_email_subscription!/1 returns the email_subscription with given id" do
      email_subscription = email_subscription_fixture()
      assert Emails.get_email_subscription!(email_subscription.id) == email_subscription
    end

    test "create_email_subscription/1 with valid data creates a email_subscription" do
      valid_attrs = %{body: "some body", to: "some to", from: "some from", subject: "some subject"}

      assert {:ok, %EmailSubscription{} = email_subscription} = Emails.create_email_subscription(valid_attrs)
      assert email_subscription.body == "some body"
      assert email_subscription.to == "some to"
      assert email_subscription.from == "some from"
      assert email_subscription.subject == "some subject"
    end

    test "create_email_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Emails.create_email_subscription(@invalid_attrs)
    end

    test "update_email_subscription/2 with valid data updates the email_subscription" do
      email_subscription = email_subscription_fixture()
      update_attrs = %{body: "some updated body", to: "some updated to", from: "some updated from", subject: "some updated subject"}

      assert {:ok, %EmailSubscription{} = email_subscription} = Emails.update_email_subscription(email_subscription, update_attrs)
      assert email_subscription.body == "some updated body"
      assert email_subscription.to == "some updated to"
      assert email_subscription.from == "some updated from"
      assert email_subscription.subject == "some updated subject"
    end

    test "update_email_subscription/2 with invalid data returns error changeset" do
      email_subscription = email_subscription_fixture()
      assert {:error, %Ecto.Changeset{}} = Emails.update_email_subscription(email_subscription, @invalid_attrs)
      assert email_subscription == Emails.get_email_subscription!(email_subscription.id)
    end

    test "delete_email_subscription/1 deletes the email_subscription" do
      email_subscription = email_subscription_fixture()
      assert {:ok, %EmailSubscription{}} = Emails.delete_email_subscription(email_subscription)
      assert_raise Ecto.NoResultsError, fn -> Emails.get_email_subscription!(email_subscription.id) end
    end

    test "change_email_subscription/1 returns a email_subscription changeset" do
      email_subscription = email_subscription_fixture()
      assert %Ecto.Changeset{} = Emails.change_email_subscription(email_subscription)
    end
  end
end
