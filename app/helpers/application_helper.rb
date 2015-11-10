module ApplicationHelper

	def login(id)
    session[:current_user_id] = id
  end

	def logged_in_user?
    return nil unless session[:current_user_id]
  end
  
  def current_user
    return unless session[:current_user_id]
    @current_user ||= User.find(session[:current_user_id])
  end

  def logged_in_users_only
    unless logged_in_user?
    	flash[:danger] = "Log in to continue"
    	redirect_to login_path
    end
  end

  def already_logged_in!
  	if logged_in_user?
	    redirect_to root_url
	    flash[:warning] = "You were already Logged In!"
		end
  end

end
