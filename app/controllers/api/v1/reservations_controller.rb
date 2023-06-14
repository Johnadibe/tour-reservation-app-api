class Api::V1::ReservationsController < ApplicationController
  def index
    user = current_user
    @reservations = Reservation.includes(:tour).where(user_id: user.id)
    render json: @reservations
  end

  def show
    @reservation = Reservation.find_by(id: params[:id])
    render json: @reservation
  end

  def create
    # @user = current_user
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.save
      render json: @reservation, status: :created, notice: 'Reservation created successfully'
    else
      render json: { error: 'Unable to create reservation' }, status: :bad_request
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_end, :end_date, :tour_id)
  end
end
