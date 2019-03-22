class UserReceipt < ActionMailer::Base
  default from: 'no-reply@jungle.com'
  def welcome_email user, order, order_details
    @user = user
    @order = order
    @order_details = order_details
    mail(to: @user, subject: 'Jungle Receipt: Order #'+ @order.id.to_s)
  end
end
