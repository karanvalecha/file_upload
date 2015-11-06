module ApplicationHelper

  def current_user
    return unless session[:current_user_id]
    @current_user ||= User.find(session[:current_user_id])
  end

end
