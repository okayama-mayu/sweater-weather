class LocationService
  def self.search_location(city)
    response = conn.get("?location=#{city}")
    response_check(response)
  end

  private 
  def self.conn 
    Faraday.new("http://www.mapquestapi.com/geocoding/v1/address") do |faraday| 
      faraday.params['key'] = ENV['mapquest_key']
    end
  end

  def self.response_check(response)
    JSON.parse(response.body, symbolize_names: true) if response.status == 200
  end
end