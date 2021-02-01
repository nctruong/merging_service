module Api
  module V1
    class HotelsController < ApplicationController
      def show
        render json: {hotel: 'abc'}
      end
    end
  end
end