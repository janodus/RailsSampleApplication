module SessionsHelper

  # Logs in the given user (ref controller)
  def log_in(user)
    session[:user_id] = user.id
  end

  # Sets/returns the current user, if login takes place
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in (current user has a return value)
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end 

end
