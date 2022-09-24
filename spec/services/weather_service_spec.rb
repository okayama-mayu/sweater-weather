require 'rails_helper' 

RSpec.describe 'WeatherService' do 
  it 'returns the relevant weather information of a given location', :vcr do 
    weather = WeatherService.search_coordinates(33.44, -94.04)

    expect(weather).to be_a Hash

    expect(weather).to include(:current, :hourly, :daily)
    expect(weather).to_not include(:minutely, :alerts)

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

    expect(weather[:daily][0][:dt]).to be_an Integer 
    expect(weather[:daily][0][:sunrise]).to be_an Integer 
    expect(weather[:daily][0][:sunset]).to be_an Integer 
    expect(weather[:daily][0][:temp][:max]).to be_a Float
    expect(weather[:daily][0][:temp][:min]).to be_a Float
    expect(weather[:daily][0][:weather][0][:description]).to be_a String
    expect(weather[:daily][0][:weather][0][:icon]).to be_a String

    expect(weather[:hourly][0][:dt]).to be_an Integer 
    expect(weather[:hourly][0][:temp]).to be_a Float
    expect(weather[:hourly][0][:weather][0][:description]).to be_a String
    expect(weather[:hourly][0][:weather][0][:icon]).to be_a String
  end
end