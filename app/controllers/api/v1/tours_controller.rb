class Api::V1::ToursController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @tours = Tour.all
    render json: @tours
  end

  def create
    @user = current_user
    @tour = Tour.new(tour_params)
    @tour.user_id = @user.id
    if @tour.save
      render json: @tour, status: :created, notice: 'Tour created successfully'
    else
      render json: { error: 'Could not create Tour successfully' }, status: :bad_request
    end
  end

  def show
    tour = Tour.find(params[:id])
    if tour
      render json: tour
    else
      render json: { error: 'Tour could not be found.' }, status: :bad_request
    end
  end

  def destroy
    @user = current_user
    @tour = Tour.find(params[:id])
    @tour.user_id = @user.id
    if @tour.destroy
      render json: { id: @tour.id, status: :deleted, notice: 'Tour deleted successfully' }
    else
      render json: { error: 'Something went wrong, Could not delete Tour successfully' }, status: :bad_request
    end
  end

  def update
    @user = current_user
    @tour = Tour.find(params[:id])
    @tour.user_id = @user.id
    if @tour.update(tour_params)
      render json: @tour, notice: 'Tour updated successfully'
    else
      render json: { error: 'Something went wrong, Could not update Tour successfully' }, status: :bad_request
    end
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :city, :price, :video, :image)
  end
end
