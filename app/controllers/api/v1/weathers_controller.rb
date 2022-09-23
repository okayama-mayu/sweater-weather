class Api::V1::WeathersController < ApplicationController 
  def index 
    data = WeatherSearchFacade.weather_search(params[:location])
    binding.pry 
  end
end