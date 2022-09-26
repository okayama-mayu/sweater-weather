class Api::V1::BooksController < ApplicationController
  def create
    data = BookFacade.book_search(params[:location], params[:quantity])
    json_response(data)
  end

  private 
    def json_response(object, status = :ok)
      render json: BookSerializer.new(object), status: status 
    end
end