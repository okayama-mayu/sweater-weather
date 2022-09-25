class Api::V1::RoadTripController < ApplicationController
  def create
    if User.exists?(password_digest: params[:api_key])
      data = WeatherSearchFacade.road_trip_search(params[:origin], params[:destination])
      json_response(data)
    else 
    end 
  end
end