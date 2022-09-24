class Api::V1::UsersController < ApplicationController 
  def create
    binding.pry 
    new_user = User.create!(user_params)
    test = user_json_response(new_user, 201)
    binding.pry 
  end

  private 
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end