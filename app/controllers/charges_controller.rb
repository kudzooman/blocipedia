class ChargesController < ApplicationController

  def create
    @amount = params[:amount]

    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: @amount,
    description: "Blocipedia Premium Membership - #{current_user.user_name}",
    currency: 'usd'
    )

    current_user.update_attribute(:role, :premium)

    redirect_to wikis_path, flash: { notice: "Thanks for your payment, #{current_user.user_name}!" }

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end