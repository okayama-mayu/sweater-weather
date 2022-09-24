class Api::V1::SessionsController < ApplicationController
  def create 
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id # don't actually need this because you don't have views 
      user_json_response(user)
    else 
      error_response('Your credentials are invalid', 401)
    end
  end
end