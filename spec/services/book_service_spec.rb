require 'rails_helper' 

RSpec.describe 'BookService' do 
  it 'returns the relevant list of books given location and quantity' do 
    books = BookService.search_books('New Orleans, LA', 3)

    expect(books).to be_a Hash 

    expect(books).to include(:numFound)
  end
end