class Api::V1::SessionsController < ApplicationController
  def create 
    user = User.find_by!(email: params[:email])
    if user&.authenticate(params[:password])
      user_json_response(user)
    else 
      error_response('Your credentials are invalid', 401)
    end
  end
end