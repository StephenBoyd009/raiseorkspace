class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         belongs_to :plan
         has_one :profiles
         
         attr_accessor :stripe_card_token
         # If Pro user passed validations (email, password, etc),
         # then call Stripe and tell Stripe to set up a subscription
         # upon charging the customer,s card
         # Store customer.id as the customer token and save the user.
         def save_with_subscription
           if valid?
             customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
             self.stripe_customer_token = customer.id
             save!
           end
         end
end
