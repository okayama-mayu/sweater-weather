require 'rails_helper' 

RSpec.describe LocationService do 
  it 'can return the latitude and longitude for the city', :vcr do 
    location = LocationService.search_location('denver, co')

    expect(location).to be_a Hash
    expect(location).to have_key(:results)

    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a Float
    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
    expect(location[:results][0][:locations][0][:latLng][:lng]).to be_a Float
  end

  it 'can return the time it takes to travel between two points', :vcr do 
    directions = LocationService.search_directions('denver, co', 'estes park, co')

    expect(directions).to be_a Hash
    expect(directions).to have_key(:route)

    expect(directions[:route]).to have_key(:time)
    expect(directions[:route][:time]).to be_an Integer 
  end
end