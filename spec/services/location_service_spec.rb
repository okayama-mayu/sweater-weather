require 'rails_helper' 

RSpec.describe LocationService do 
  describe 'Location Service' do 
    it 'can return the latitude and longitude for the city', :vcr do 
      location = LocationService.search_location('denver, co')

      expect(location).to be_a Hash
      expect(location).to have_key(:results)

      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(location[:results][0][:locations][0][:latLng][:lng]).to be_a Float
    end
  end
end