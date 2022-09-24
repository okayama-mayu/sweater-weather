require 'rails_helper' 

RSpec.describe 'WeatherService' do 
  it 'returns the relevant weather information of a given location', :vcr do 
    weather = WeatherService.search_coordinates(33.44, -94.04)

    expect(weather).to be_a Hash

    expect(weather).to have_key(:current, :hourly, :daily)
    expect(weather).to_not have_key(:minutely, :alerts)

    expect(weather[:current][:dt]).to be_an Integer # unix time; UTC = Time.at(unix)
    expect(weather[:current][:sunrise]).to be_an Integer 
    expect(weather[:current][:sunset]).to be_an Integer 
    expect(weather[:current][:temp]).to be_a Float 
    expect(weather[:current][:feels_like]).to be_a Float 
    expect(weather[:current][:humidity]).to be_an Integer 
    expect(weather[:current][:uvi]).to be_a Numeric 
    expect(weather[:current][:visibility]).to be_a Numeric 
    expect(weather[:current][:weather][0][:description]).to be_a String
    expect(weather[:current][:weather][0][:icon]).to be_a String

    expect(weather[:daily][:dt]).to be_an Integer 
    expect(weather[:daily][:sunrise]).to be_an Integer 
    expect(weather[:daily][:sunset]).to be_an Integer 
    expect(weather[:daily][:temp][:max]).to be_a Float
    expect(weather[:daily][:temp][:min]).to be_a Float
    expect(weather[:daily][:weather][0][:description]).to be_a String
    expect(weather[:daily][:weather][0][:icon]).to be_a String

    expect(weather[:hourly][:dt]).to be_an Integer 
    expect(weather[:hourly][:temp]).to be_a Float
    expect(weather[:hourly][:weather][0][:description]).to be_a String
    expect(weather[:hourly][:weather][0][:icon]).to be_a String
  end
end