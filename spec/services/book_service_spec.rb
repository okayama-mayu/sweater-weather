require 'rails_helper' 

RSpec.describe 'BookService' do 
  it 'returns the relevant list of books given location and quantity', :vcr do 
    books = BookService.search_books('Denver, CO', 3)

    expect(books).to be_a Hash 

    expect(books).to include(:numFound)
    expect(books[:docs]).to be_an Array 
    expect(books[:docs].count).to eq 3 

    books[:docs].each do |book| 
      expect(book).to include(:isbn, :title, :publisher)
      expect(book[:isbn]).to be_an Array 
      expect(book[:isbn][0]).to be_a String 
      expect(book[:title]).to be_a String 
      expect(book[:publisher]).to be_an Array 
      expect(book[:publisher][0]).to be_a String
    end 
  end
end