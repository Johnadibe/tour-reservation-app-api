class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
        token = issue_token(user)
        render json: {user: UserSerializer.new(user), token: token}
    else
        if user.errors.messages
            render json: {error: user.errors.messages}
        else
            render json:  {error: "User could not be created. Try again"}
        end
    end
  end

  private

  def user_params
      params.permit(:name, :email, :password)
  end

end
