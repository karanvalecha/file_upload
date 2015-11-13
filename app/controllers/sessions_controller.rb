class SessionsController < ApplicationController

  before_action :already_logged_in!, only: :new

  def new
    @user = User.new unless logged_in_user?
  end

  def create
    stuff = params[:session] # Submited login data inside :session
    user = User.find_by(email: stuff[:email].downcase)

    if user && user.authenticate(stuff[:password])
      login(user.id)
      flash[:success] = "Login Success"
      redirect_to root_url
    else
      flash.now[:danger] = "Unauthorised Access"
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:warning] = "Logged Out!"
    redirect_to root_url
  end

end
