class Api::V1::UsersController < ApplicationController 
  def create
    new_user = User.create!(user_params)
    test = user_json_response(new_user)
    binding.pry 
  end

  private 
    def user_params
      params.require(:user).permit(:email, :password)
    end
end