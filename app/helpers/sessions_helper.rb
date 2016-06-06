module SessionsHelper
  #Logs in the given user
  def log_in(user) 
    session[:user_id] = user.id # the session method creates a temp cookie in the browser(expires with a closed browser!)
  end
  
  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  
end
