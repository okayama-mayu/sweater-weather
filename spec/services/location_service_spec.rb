require 'rails_helper' 

RSpec.describe LocationService do 
  describe 'Location Service' do 
    it 'can return the latitude and longitude for the city' do 
      location = LocationService.search_location('denver, co')

      expect(location).to be_a Hash
      expect(location).to have_key(:results)

      expect(data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(data[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(data[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(data[:results][0][:locations][0][:latLng][:lng]).to be_a Float
    end
  end
end