require 'rails_helper' 

RSpec.describe Location do 
  it 'exists and has latitude and longitude' do 
    response = file_fixture('sample_location_data.txt').read 

    data = JSON.parse(response, symbolize_names: true)

    location = Location.new(data)

    expect(location).to be_a Location 
    expect(location.lat).to eq 38.892062
    expect(location.lng).to eq -77.019912
  end
end