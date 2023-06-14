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

end