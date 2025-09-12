module Api
  module V1
    class PingsController < ApplicationController
      def show
        render json: { message: "pong" }
      end
    end
  end
end
