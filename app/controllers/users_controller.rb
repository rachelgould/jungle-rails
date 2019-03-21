class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts user_params
    puts "---------------------"
    puts @user.errors.inspect
    if @user.save
      puts "0000000000"
      puts @user.id
      puts "0000000000"
      session[:user_id] = @user.id
      redirect_to '/', notice: 'Signed up!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password,
      :password_confirmation
    )
  end

end
