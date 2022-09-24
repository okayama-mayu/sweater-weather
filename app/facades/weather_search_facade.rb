class WeatherSearchFacade 
  def self.weather_search(location)
    location_data = LocationService.search_location(location)
    coordinates = Location.new(location_data)
    weather_data = WeatherService.search_weather(coordinates.lat, coordinates.lng)
    weather = Weather.new(weather_data)
  end
end