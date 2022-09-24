require 'rails_helper'

RSpec.describe Forecast do 
  it 'exists and has all attributes' do 
    response = file_fixture('sample_forecast_data.txt').read 

    data = JSON.parse(response, symbolize_names: true)

    forecast = Forecast.new(data)

    expect(forecast).to be_a Forecast 

    expect(forecast.current_weather[:datetime]).to eq Time.at(1663988361) # unix time; UTC = Time.at(unix)
    expect(forecast.current_weather[:sunrise]).to eq Time.at(1663934697)
    expect(forecast.current_weather[:sunset]).to eq Time.at(1663978326)
    expect(forecast.current_weather[:temperature]).to eq 298.29
    expect(forecast.current_weather[:feels_like]).to eq 298.71
    expect(forecast.current_weather[:humidity]).to eq 71
    expect(forecast.current_weather[:uvi]).to eq 0
    expect(forecast.current_weather[:visibility]).to eq 10000
    expect(forecast.current_weather[:conditions]).to eq "clear sky"
    expect(forecast.current_weather[:icon]).to eq "01n"

    expect(forecast[:daily_weather].count).to eq 5
    expect(forecast[:daily_weather][0][:date]).to eq Time.at(1663956000).strftime("%Y-%m-%e")
    expect(forecast[:daily_weather][0][:sunrise]).to eq Time.at(1663934697)
    expect(forecast[:daily_weather][0][:sunset]).to eq Time.at(1663978326)
    expect(forecast[:daily_weather][0][:max_temp]).to eq 304.17
    expect(forecast[:daily_weather][0][:min_temp]).to eq 289.97
    expect(forecast[:daily_weather][0][:conditions]).to eq "clear sky"
    expect(forecast[:daily_weather][0][:icons]).to eq "01d"

    expect(forecast[:hourly_weather].count).to eq 5 
    expect(forecast[:hourly_weather][0][:time]).to eq Time.at(1663984800).strftime("%I:%M:%S")
    expect(forecast[:hourly_weather][0][:temperature]).to eq 298.11
    expect(forecast[:hourly_weather][0][:conditions]).to eq "clear sky"
    expect(forecast[:hourly_weather][0][:icon]).to eq "01n"
    
  end
end