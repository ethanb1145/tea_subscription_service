require "rails_helper"

RSpec.describe "Subscriptions API", type: :request do
  describe "GET /api/v1/customers/:customer_id/subscriptions" do
    it "returns a list of subscriptions for a customer" do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer: customer, tea: tea)

      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)
      expect(data).to have_key("data")
      subscriptions_data = data["data"]

      expect(subscriptions_data).to be_an(Array)
      expect(subscriptions_data.first).to have_key("id")
      expect(subscriptions_data.first).to have_key("attributes")
      expect(subscriptions_data.first["attributes"]).to have_key("title")
      expect(subscriptions_data.first["attributes"]).to have_key("price")
    end
  end

  describe "POST /api/v1/customers/:customer_id/subscriptions" do
    it "creates a new subscription" do
      customer = create(:customer)
      tea = create(:tea)

      subscription_params = {
        subscription: {
          title: "Weekly Black Tea",
          price: 12.99,
          frequency: "weekly",
          tea_id: tea.id
        }
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", params: subscription_params

      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)

      expect(data).to have_key("data")
      subscription_data = data["data"]

      expect(subscription_data).to have_key("id")
      expect(subscription_data).to have_key("attributes")
      expect(subscription_data["attributes"]).to have_key("title")
      expect(subscription_data["attributes"]).to have_key("price")
      expect(subscription_data["attributes"]).to have_key("status")
    end

    it "returns error if subscription creation fails" do
      customer = create(:customer)

      invalid_subscription_params = {
        subscription: {
          title: "",
          price: nil,
          frequency: "weekly",
          tea_id: nil
        }
      }

      post "/api/v1/customers/#{customer.id}/subscriptions", params: invalid_subscription_params

      expect(response).to have_http_status(:unprocessable_entity)
      data = JSON.parse(response.body)

      expect(data).to_not have_key("data")
      expect(data).to have_key("errors")
      expect(data["errors"]).to_not be_empty
    end
  end

  describe "PATCH /api/v1/customers/:customer_id/subscriptions/:id" do
    it "updates a subscription to be active or cancelled" do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer: customer, tea: tea)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: { subscription: { status: "cancelled" } }

      expect(response).to have_http_status(200)
      data = JSON.parse(response.body)

      expect(data).to have_key("data")
      updated_subscription_data = data["data"]

      expect(updated_subscription_data).to have_key("id")
      expect(updated_subscription_data).to have_key("attributes")
      expect(updated_subscription_data["attributes"]).to have_key("status")
      expect(updated_subscription_data["attributes"]["status"]).to eq("cancelled")
    end
  end
end