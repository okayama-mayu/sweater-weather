class WeatherSearchFacade 
  def self.weather_search(location)
    location_data = LocationService.search_location(location)
    coordinates = Location.new(location_data)
    weather_data = WeatherService.search_coordinates(coordinates.lat, coordinates.lng)
    forecast = Forecast.new(weather_data)
  end
end