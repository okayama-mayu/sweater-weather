class WeatherSearchFacade 
  def self.weather_search(location)
    location_data = LocationService.search_location(location)
    coordinates = Location.new(location_data)
    weather_data = WeatherService.search_coordinates(coordinates.lat, coordinates.lng)
    forecast = Forecast.new(weather_data)
  end

  def self.road_trip_search(origin, destination)
    weather_data = weather_search(destination)
    time_data = LocationService.search_directions(origin, destination)
    time_lapsed = time_data[:route][:time]

    Roadtrip.new(origin, destination, weather_data, time_lapsed)
  end
end