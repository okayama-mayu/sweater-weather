require 'rails_helper' 

RSpec.describe Book do 
  it 'exists and has id, destination, forecast, total_books_found, and an array of boooks', :vcr do 
    location = 'denver, co'
    quantity = 10 

    weather_data = WeatherSearchFacade.weather_search(location).current_weather

    book_data = BookService.search_books(location, quantity)

    books = Book.new(location, weather_data, book_data)

    expect(books).to be_a Book 
    expect(books.id).to eq 'null' 
    expect(books.destination).to eq location 

    expect(books.forecast[:summary]).to be_a String 
    expect(books.forecast[:temperature]).to be_a String 

    expect(books.total_books_found).to be_an Integer

    expect(books.books.count).to eq quantity 

    books.books.take(3).each do |book| 
      expect(book).to include(:isbn, :title, :publisher)
      expect(book[:isbn]).to be_an Array 
      expect(book[:isbn][0]).to be_a String 
      expect(book[:title]).to be_a String 
      expect(book[:publisher]).to be_an Array 
      expect(book[:publisher][0]).to be_a String 
    end
  end
end