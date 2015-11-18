module Helpers
  def login(user)
    request.session[:user] = user.id
  end

  def current_user
    User.find(request.session[:user])
  end
end