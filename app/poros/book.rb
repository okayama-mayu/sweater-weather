class Book 
  attr_reader :id, :destination, :forecast, :total_books_found, :books 

  def initialize(location, weather_data, books_data)
    @id = "null" 
    @destination = location 
    @forecast = pull_weather(weather_data)
    @total_books_found = books_data[:numFound]
    @books = pull_books(books_data)
  end

  def pull_weather(weather_data)
    {
      summary: weather_data[:conditions], 
      temperature: "#{weather_data[:temperature].round} F"
    }
  end

  def pull_books(books_data)
    books_data[:docs].map do |book| 
      {
        isbn: book[:isbn], 
        title: book[:title], 
        publisher: book[:publisher]
      }
    end
  end
end