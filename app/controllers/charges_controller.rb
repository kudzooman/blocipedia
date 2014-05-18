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

    flash[:success] = "Thanks for your payment, #{current_user.user_name}!"
    redirect_to user_path(current_user) # or wherever

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
  # Because large hashes in haml are no fun
  @stripe_btn_hash = {
    src: "http://checkout.strip.com/checkout.js",
    :class => 'stripe-button',
    # src: "https://checkout.stripe.com/checkout.js", 
    # class: 'stripe-button',
    data: {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.user_name}",
      amount: 9_000_000_000_00 
      # We're like the Snapchat for Wikipedia. But really, 
      # change this amount. Stripe won't charge $9 billion.
    }
  }.html_safe
end

end