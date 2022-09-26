require 'rails_helper' 

RSpec.describe 'BookService' do 
  it 'returns the relevant list of books given location and quantity', :vcr do 
    books = BookService.search_books('Denver, CO', 3)

    expect(books).to be_a Hash 

    expect(books).to include(:numFound)
    expect(books[:docs]).to be_an Array 
    expect(books[:docs].count).to eq 3 
    expect(books[:docs].first).to include(:isbn, :title, :publisher)
    expect(books[:docs].first[:isbn]).to be_an Array 
    expect(books[:docs].first[:isbn][0]).to be_a String 
    expect(books[:docs].first[:title]).to be_a String 
    expect(books[:docs].first[:publisher]).to be_an Array 
    expect(books[:docs].first[:publisher][0]).to be_a String 
  end
end