class UsersController < ApplicationController

  before_action :already_logged_in!, only: :new
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)

    if user.save
      session[:current_user_id] = user.id
      redirect_to root_url
    else
      flash[:danger] = user.errors.messages
      redirect_to signup_path
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
