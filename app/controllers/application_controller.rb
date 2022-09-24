class ApplicationController < ActionController::API
  include Response, ExceptionHandler
  # helper_method :current_user  # don't actually need this because you don't have views 

  # def current_user # don't actually need this because you don't have views 
  #   User.find(session[:user_id]) if session[:user_id]
  # end
end
