class ApplicationController < ActionController::Base
  protect_from_forgery
	
 private

 def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end

 helper_method :current_user

  #before_filter :require_login
 
  private
 
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url # halts request cycle
    end
  end
 
  # The logged_in? method simply returns true if the user is logged
  # in and false otherwise. It does this by "booleanizing" the
  # current_user method we created previously using a double ! operator.
  # Note that this is not common in Ruby and is discouraged unless you
  # really mean to convert something into true or false.
  def logged_in?
    !!current_user
  end


  private
 
  def require_admin_login
    unless admin_logged_in?
      flash[:error] = "You must be logged in as ADMIN to access this section"
      redirect_to root_url # halts request cycle
    end
  end
 
  def admin_logged_in?
    current_user.administrator
  end

end
