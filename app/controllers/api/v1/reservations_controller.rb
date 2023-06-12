class ReservationsController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])
    @reservations = user.reservations
  end
  def show
    @reservation = Reservation.find_by(id: params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.create(reservation_params)
    if @reservation.save
      redirect_to reservations_path
    else
      render :new
    end
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
