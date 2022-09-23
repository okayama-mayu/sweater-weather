class LocationService
  def self.conn 
    Faraday.new("http://www.mapquestapi.com/geocoding/v1/address") do |faraday| 
      faraday.params['key']
    end
  end
end