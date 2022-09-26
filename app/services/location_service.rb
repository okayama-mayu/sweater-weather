class LocationService
  def self.search_location(city)
    response = conn_lat_long.get("?location=#{city}")
    response_check(response)
  end

  def self.search_directions(origin, destination)
    response = conn_time.get("?from=#{origin}&to=#{destination}")
    response_check(response)
  end

  private 
  def self.conn_lat_long
    Faraday.new("http://www.mapquestapi.com/geocoding/v1/address") do |faraday| 
      faraday.params['key'] = ENV['mapquest_key']
    end
  end

  def self.conn_time
    Faraday.new("http://www.mapquestapi.com/directions/v2/route") do |faraday|
      faraday.params['key'] = ENV['mapquest_key']
    end
  end

  def self.response_check(response)
    JSON.parse(response.body, symbolize_names: true) if response.status == 200
  end
end