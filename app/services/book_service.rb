class BookService 
  def self.search_books(location, quantity)
    response = conn.get("/search.json?q=#{location}&limit=#{quantity}")
    response_check(response)
  end

  private 
    def self.conn 
      
    end
end