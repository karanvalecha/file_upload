class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_user
    return nil unless session[:current_user_id]
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def logged_in_user?
    session[:current_user_id].present?
  end

  def already_logged_in!
    if logged_in_user?
      redirect_to root_url
      flash[:warning] = "You were already Logged In!"
    end
  end

end
