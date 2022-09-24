class Api::V1::WeathersController < ApplicationController 
  def index 
    data = WeatherSearchFacade.weather_search(params[:location])
    if data.class == Forecast
      json_response(data)
    else 
      error_handle(data)
    end
  end

  private 
    def json_response(object, status = :ok)
      render json: ForecastSerializer.new(object), status: status 
    end

    def error_handle(object)
      render json: object[:message], status: 404 
    end
end