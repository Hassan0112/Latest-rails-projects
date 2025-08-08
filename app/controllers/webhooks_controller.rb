class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      Rails.logger.error("Webhook Error: #{e.message}")
      return head :bad_request
    end

    case event['type']
    when 'payment_intent.succeeded'
      intent = event['data']['object']
      Rails.logger.info("✅ Payment succeeded: #{intent['id']}")
    when 'payment_intent.payment_failed'
      Rails.logger.info("❌ Payment failed")
    else
      Rails.logger.info("Unhandled event: #{event['type']}")
    end

    head :ok
  end
end
