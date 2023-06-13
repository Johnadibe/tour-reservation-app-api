class Api::V1::ReservationsController < ApplicationController
  def index
    authenticate_user!

    user = current_user
    @reservations = Reservation.includes(:tour).where(user_id: user.id)
  
    render json: @reservations
    # @reservation = Reservation.all
  end
  def show
    @reservation = Reservation.find_by(id: params[:id])
    render json: @reservation
  end

  def new
    @reservation = Reservation.new
  end

  def create
   @reservation = Reservation.new(reservation_params);

   respond_to do |format|
   if @reservation.save
    format.html { redirect_to api_v1_user_reservations_path, notice: 'Reservation was successfully created.' }
    format.json { render json: @reservation, status: :created }
   else 
    format.html { render :new }
    format.json { render json: @reservation.errors, status: :unprocessable_entity }
   end
  end

  private 

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
