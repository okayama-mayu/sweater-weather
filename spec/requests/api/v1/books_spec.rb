require 'rails_helper' 

RSpec.describe 'Book CRUD' do 
  describe 'create Book' do 
    it 'creates a Book given location and quantity', :vcr do 
      body = ({
        "location": "Denver, CO", 
        "quantity": 5 
      })

      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/book-search", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response).to have_http_status 200

      books = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(books).to have_key(:id)
      expect(books[:id]).to eq nil

      expect(books).to have_key(:type)
      expect(books[:type]).to eq "book"

      expect(books[:attributes]).to have_key(:destination)
      expect(books[:attributes][:destination]).to eq "Denver, CO"

      expect(books[:attributes][:forecast][:summary]).to be_a String
      expect(books[:attributes][:forecast][:temperature]).to be_a String

      expect(books[:attributes][:total_books_found]).to be_an Integer

      expect(books[:attributes][:books].count).to eq 5 

      books[:attributes][:books].each do |book| 
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an Array 
        expect(book[:isbn][0]).to be_a String 

        expect(book).to have_key(:title)
        expect(book[:title]).to be_a String

        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an Array
        expect(book[:publisher][0]).to be_a String 
      end
    end
  end
end