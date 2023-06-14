class Api::V1::ReservationsController < ApplicationController
  def index
    user = current_user
    @reservations = Reservation.includes(:tour).where(user_id: user.id)
    if @reservations.length == 0
      render json: { error: "There are no reservations" }, status: :not_found
    else
      render json: @reservations
    end
  end

  def show
    @reservation = Reservation.find_by(id: params[:id])
    if @reservation.nil?
      render json: { error: "There is no reservation" }, status: :not_found
    else
    render json: @reservation
    end
  end

  def create
    @user = current_user
    p @user.id
    @reservation = Reservation.create(reservation_params)
    @reservation.user_id = @user.id
    p @reservation
    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { error: "Unable to create reservation" }, status: :bad_request
    end 
  end

  private 
  def reservation_params
    params.require(:reservation).permit(:start_end, :end_date, :tour_id)
  end
end