class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def jwt_key
    Rails.application.credentials.jwt_key
  end

  def generate_token(user)
    JWT.encode({ user_id: user.id }, jwt_key, 'HS256')
  end

  def decoded_token
    token = request.headers['Authorization']&.split(' ')&.last
    JWT.decode(token, jwt_key, true, { algorithm: 'HS256' })
  rescue JWT::DecodeError
    [{ error: 'Invalid Token' }]
  end

  def user_id
    decoded_token.first['user_id']
  end

  def current_user
    User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
