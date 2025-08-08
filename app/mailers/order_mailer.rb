class OrderMailer < ApplicationMailer
    
    def confirmation_email
        @order = params[:order]
        mail(to: @order.user.email, subject: "Your Order Confirm")
    end
end
