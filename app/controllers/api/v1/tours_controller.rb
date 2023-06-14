class Api::V1::ToursController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]

    def index 
        @tours = Tour.all
        render json: @tours
    end

end