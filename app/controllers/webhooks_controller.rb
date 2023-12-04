# app/controllers/webhooks_controller.rb
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = 'whsec_1sLLo08d9iRjdDfSloRu8ImMD9hC4ktn' # Replace with your actual Stripe webhook secret key
    # endpoint_secret = Rails.application.credentials.stripe[:webhook_secret]

    # Verify the webhook signature
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render status: :bad_request, json: { error: 'Invalid payload' }
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render status: :unauthorized, json: { error: 'Invalid signature' }
      return
    end

    # Handle the event
    case event['type']
    when 'payment_intent.succeeded'
      puts '<<<<<<<<<<<<<<<<<<<<<<<<<..................PaymentIntent was succeed'
      # Handle successful payment
      # Your logic here
    when 'payment_intent.payment_failed'
      puts '<<<<<<<<<<<<<<<<<<<<<<<<<..................PaymentIntent was failed'
      # Handle failed payment
      # Your logic here
    end

    render json: { status: 'success' }
  end
end
