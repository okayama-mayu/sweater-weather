class Api::V1::SessionsController < ApplicationController
  def create 
    user = User.find_by!(email: params[:email])
    if user&.authenticate(params[:password])
      user_json_response(user)
    else 
      
    end
  end
end