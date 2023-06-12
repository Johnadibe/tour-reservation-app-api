class ReservationsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    @reservations = user.reservations
  end
end
