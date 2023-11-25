class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.new(subscription_params)
    subscription.status = Subscription.statuses[:subscribed]

    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: "Subscription not created." }, status: :unprocessable_entity
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    begin
      subscription.update(status: params[:subscription][:status])
      render json: SubscriptionSerializer.new(subscription)
    rescue ArgumentError => e
      render json: { errors: "#{e.message}. Use 'subscribed' or 'cancelled'." }, status: :unprocessable_entity
    end
  end

  private 

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :tea_id)
  end
end