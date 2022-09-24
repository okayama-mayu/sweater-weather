class WeatherService 
  def self.search_coordinates(lat, lng)
    response = conn.get("/data/2.5/onecall?lat=#{lat}&lon=#{lng}&exclude=minutely,alerts&units=imperial")
    response_check(response)
  end

  private 
  def self.conn 
    Faraday.new("https://api.openweathermap.org") do |faraday| 
      faraday.params['appid'] = ENV['weather_key']
    end
  end

  def self.response_check(response)
    JSON.parse(response.body, symbolize_names: true) if response.status == 200
  end
end