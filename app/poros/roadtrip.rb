class Roadtrip 
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination, weather_data, time_lapsed)
    @id = nil 
    @start_city = origin 
    @end_city = destination
    @travel_time = find_time_lapsed(time_lapsed)
    @weather_at_eta = find_weather(weather_data, time_lapsed)
  end

  def find_time_lapsed(time_lapsed)
    "%02d hours %02d minutes" % [time_lapsed / 3600, time_lapsed / 60 % 60]
  end

  def find_weather(weather_data, time_lapsed) 
    eta = find_eta(weather_data, time_lapsed)

    data = pull_data(weather_data, eta, time_lapsed)

    create_hash(data, time_lapsed)
  end

  def find_eta(weather_data, time_lapsed)
    current_unix_time = weather_data[:current][:dt]

    if time_lapsed <= 172800 
      times = weather_data[:hourly].map { |hour| hour[:dt] }
    else 
      times = weather_data[:daily].map { |day| day[:dt] }
    end 
    
    times.min_by { |time| (current_unix_time + time_lapsed - time).abs }
  end

  def pull_data(weather_data, eta, time_lapsed)
    if time_lapsed <= 172800 
      data = weather_data[:hourly].find { |hour| hour[:dt] == eta }
    else 
      data = weather_data[:daily].find { |day| day[:dt] == eta }
    end 
  end

  def create_hash(data, time_lapsed)
    if time_lapsed <= 172800 
      {
        :temperature => data[:temp], 
        :conditions => data[:weather][0][:description]
      }
    else 
      {
        :temperature => data[:temp][:day], 
        :conditions => data[:weather][0][:description]
      }
    end 
  end
end