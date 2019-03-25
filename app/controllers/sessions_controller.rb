class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists and the password entered is correct
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user ID inside the browser cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end
end
