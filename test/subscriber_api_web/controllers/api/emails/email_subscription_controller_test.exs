defmodule SubscriberApiWeb.API.Emails.EmailSubscriptionControllerTest do
  use SubscriberApiWeb.ConnCase

  import SubscriberApi.EmailsFixtures

  alias SubscriberApi.Emails.EmailSubscription

  @create_attrs %{
    body: "some body",
    to: "some to",
    from: "some from",
    subject: "some subject"
  }
  @update_attrs %{
    body: "some updated body",
    to: "some updated to",
    from: "some updated from",
    subject: "some updated subject"
  }
  @invalid_attrs %{body: nil, to: nil, from: nil, subject: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all email_subscription", %{conn: conn} do
      conn = get(conn, ~p"/api/api/emails/email_subscription")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create email_subscription" do
    test "renders email_subscription when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/emails/email_subscription", email_subscription: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/emails/email_subscription/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some body",
               "from" => "some from",
               "subject" => "some subject",
               "to" => "some to"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/emails/email_subscription", email_subscription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update email_subscription" do
    setup [:create_email_subscription]

    test "renders email_subscription when data is valid", %{conn: conn, email_subscription: %EmailSubscription{id: id} = email_subscription} do
      conn = put(conn, ~p"/api/api/emails/email_subscription/#{email_subscription}", email_subscription: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/emails/email_subscription/#{id}")

      assert %{
               "id" => ^id,
               "body" => "some updated body",
               "from" => "some updated from",
               "subject" => "some updated subject",
               "to" => "some updated to"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, email_subscription: email_subscription} do
      conn = put(conn, ~p"/api/api/emails/email_subscription/#{email_subscription}", email_subscription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete email_subscription" do
    setup [:create_email_subscription]

    test "deletes chosen email_subscription", %{conn: conn, email_subscription: email_subscription} do
      conn = delete(conn, ~p"/api/api/emails/email_subscription/#{email_subscription}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/emails/email_subscription/#{email_subscription}")
      end
    end
  end

  defp create_email_subscription(_) do
    email_subscription = email_subscription_fixture()
    %{email_subscription: email_subscription}
  end
end
