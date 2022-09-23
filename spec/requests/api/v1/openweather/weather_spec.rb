require 'rails_helper' 

RSpec.describe 'Weather GET call' do 
  it 'can retrieve weather for a city' do 
    headers = { "CONTENT_TYPE" => "application/json" }
    location_param = ( { location: "denver, co" })

    get "/api/v1/weathers", headers: headers, params: location_param

    expect(response).to be_successful 

    response_details = JSON.parse(response.body, symbolize_names: true)

    forecast = response_details[:data]

    expect(forecast[:id]).to eq nil 
    expect(forecast[:type]).to eq 'forecast' 
    expect(forecast[:attributes]).to include(:current_weather, :daily_weather, :hourly_weather)
    expect(forecast[:attributes][:current_weather]).to include(:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon)
    expect(forecast[:attributes][:daily_weather]).to include(:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon)
    expect(forecast[:attributes][:hourly_weather]).to include(:time, :temperature, :conditions, :icon)
    expect(forecast[:attributes]).to_not include(:alerts, :minutely_weather)
  end
end