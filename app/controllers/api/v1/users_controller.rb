class Api::V1::UsersController < ApplicationController 
  def create
    new_user = User.create!(user_params)
    session[:user_id] = new_user.id # don't actually need this because you don't have views 
    user_json_response(new_user, 201)
  end

  private 
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end