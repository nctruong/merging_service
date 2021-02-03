module Api
  module V1
    class HotelsController < ApplicationController
      
      # http://localhost:3000/api/v1/hotels?id=iJhz&destination=5432
      def show
        id          = params[:id]
        destination = params[:destination]
        
        hotel = ProcuredHotel.find_by(hotel_id: id, destination_id: destination)
        render json: JSON.parse(hotel.data)
      end
    end
  end
end
