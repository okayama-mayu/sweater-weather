class Api::V1::WeathersController < ApplicationController 
  def index 
    data = WeatherSearchFacade.weather_search(params[:location])
    json_response(data)
  end

  private 
    def json_response(object, status = :ok)
      render json: ForecastSerializer.new(object), status: status 
    end
end