class UserReceipt < ActionMailer::Base
  def welcome_email user, order, order_details
    puts "-----------------------------"
    puts "@user:", user
    puts "-----------------------------"
    puts "@order:", order
    puts "-----------------------------"
    puts "@order_details:", order_details
    puts "-----------------------------"
    @user = user
    @order = order
    @order_details = order_details
    mail(to: @user, subject: 'Jungle Receipt: Order #{@order.id}', body: 'Something')
  end
end
