class BookService 
  def self.search_books(location, quantity)
    response = conn.get("/search.json?q=#{location}&limit=#{quantity}")
    response_check(response)
  end

  private 
    def self.conn 
      Faraday.new("https://openlibrary.org") 
    end

    def self.response_check(response)
      JSON.parse(response.body, symbolize_names: true) if response.status == 200
    end
end