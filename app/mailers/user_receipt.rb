class UserReceipt < ActionMailer::Base
  default from: 'notifications@example.com'
  def welcome_email user, order, order_details
    puts "-----------------------------"
    puts "@user:", user.inspect
    puts "-----------------------------"
    puts "@order:", order.inspect
    puts "-----------------------------"
    puts "@order_details:", order_details.inspect
    puts "-----------------------------"
    @user = user
    @order = order
    @order_details = order_details
    mail(to: @user, subject: 'Jungle Receipt: Order #{order.id}')
  end
end
