class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @current_weather = current_weather(data)
    @daily_weather = daily_weather(data)
    binding.pry 
  end

  def current_weather(data)
    {
      datetime: Time.at(data[:current][:dt]), 
      sunrise: Time.at(data[:current][:sunrise]),
      sunset: Time.at(data[:current][:sunset]),
      temperature: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
  end

  def daily_weather(data)
    data[:daily].take(5).map do |day| 
      {
        date: Time.at(day[:dt]).strftime("%Y-%m-%e"), 
        sunrise: Time.at(day[:sunrise]), 
        sunset: Time.at(day[:sunset]), 
        max_temp: day[:temp][:max], 
        min_temp: day[:temp][:min], 
        conditions: day[:weather][0][:description], 
        icons: day[:weather][0][:icon] 
      }
    end
  end
end