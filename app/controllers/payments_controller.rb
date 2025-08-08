class PaymentsController < ApplicationController
  protect_from_forgery except: :create         # accept JSON POST

  def new
    # nothing here – just renders the view
  end

  def create
    intent = Stripe::PaymentIntent.create(
      amount: 1000,             # $10.00
      currency: 'usd',
      automatic_payment_methods: { enabled: true }
    )

    render json: { client_secret: intent.client_secret }
  end
end
