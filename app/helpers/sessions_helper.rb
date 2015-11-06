module SessionsHelper
  def logged_in_user?
    if session[:current_user_id]
      flash[:warning] = "You were already logged in"
      redirect_to root_url
      return true
    else
      return false
    end
  end

  def login(id)
    session[:current_user_id] = id
  end
end
