module Response 
  def user_json_response(object, status = :ok)
    render json: UserSerializer.new(object, status: status)
  end
end