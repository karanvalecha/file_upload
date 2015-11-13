module ApplicationHelper

  def login(id)
    session[:current_user_id] = id || nil
  end

  def current_user
    return nil unless session[:current_user_id]
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def logged_in_users_only
    unless logged_in_user?
    	flash[:danger] = "Log in to continue"
    	redirect_to login_path
    end
  end

end
