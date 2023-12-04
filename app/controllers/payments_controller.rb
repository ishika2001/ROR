class PaymentsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          product_data: {
            name: @event.title,
            description: @event.description,
            images: []#'https://media.istockphoto.com/id/1328049157/photo/mens-short-sleeve-t-shirt-mockup-in-front-and-back-views.jpg?b=1&s=170667a&w=0&k=20&c=CZ5Emlrh-C4jzojJ8b8YBy1frxpQr6aMcLmEBrkty7Q=']
          },
          unit_amount: 1000
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "http://localhost:3000/show?id=#{@event.id}",
      cancel_url: 'http://localhost:3000/payments/cancel'
    )
  end
  def success
    # Handle successful payment
    # You can access the Checkout Session ID via params[:session_id]
    flash[:success] = "Payment successful!"
    render "/events/show?id=#{@event.id}"
  end

  def cancel
    flash[:error] = "Payment cancelled."
    redirect_to products_path
  end
end
