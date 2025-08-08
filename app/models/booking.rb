class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  monetize  :total_amount_cents  #  using money-rails gem


  # A method to actually create a Stripe charge and transfer to the seller:
  def charge_with_stripe
    seller_account = listing.user.stripe_account_id
    Stripe::PaymentIntent.create({
      amount: total_amount_cents,
      currency: "usd",
      payment_method_types: ["card"],
      payment_method: payment_method_id_from_frontend,  # obtain this from Stripe.js
      confirmation_method: "manual",
      confirm: true,
      transfer_data: {
        destination: seller_account  # this routes funds directly to seller’s Connect account
      },
      application_fee_amount: platform_fee_cents  # if you want to take a cut
    })
  end
end
