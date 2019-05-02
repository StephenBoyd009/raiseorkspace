class Users::RegistrationsController < Devise::RegistrationsController
  #  controller and user.rbExtend default Sevise gem behavior so that
  # Users signing up with the Pro account (plan ID 2)
  # save with a special Stripe subscription function
  # Otherwise Devise signs up as usual
    def create
      super do |resource|  
          if params[:plan]
              resource.plan_id = params[:plan]
              if resource.plan_id ==2
                  resource.save_with_subscription
              else
                  resource.save
              end
          end
      end
    end
end