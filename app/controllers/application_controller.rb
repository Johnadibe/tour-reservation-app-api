class ApplicationController < ActionController::API
    def generate_token(user)
        JWT.encode({ user_id: user.id }, Rails.application.credentials.jwt_key, 'HS256')
    end
end
