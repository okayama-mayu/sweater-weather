class WeatherSearchFacade 
  # one facade per controller (differing opinions!)
  # 'WeatherSearchFacade' should only look for weather stuff; single responsibility principle!
  # can call on other facades from another facade 
  def self.weather_search(location)
    # location_data = LocationService.search_location(location)
    # coordinates = Location.new(location_data)
    # weather_data = WeatherService.search_coordinates(coordinates.lat, coordinates.lng)
    weather_data = weather_data_raw(location)
    forecast = Forecast.new(weather_data)
  end

  def self.road_trip_search(origin, destination)
    weather_data = weather_data_raw(destination)
    time_data = LocationService.search_directions(origin, destination)
    time_lapsed = time_data[:route][:time]
    
    Roadtrip.new(origin, destination, weather_data, time_lapsed)
  end

  def self.weather_data_raw(location)
    location_data = LocationService.search_location(location)
    coordinates = Location.new(location_data)
    weather_data = WeatherService.search_coordinates(coordinates.lat, coordinates.lng)
  end

  def self.book_search(location, quantity)
    weather_data = weather_search(location).current_weather
    books_data = BookService.search_books(location, quantity)

    Book.new(location, weather_data, books_data)
  end
end