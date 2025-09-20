module Api
  module V1
    class OccupationsController < ApplicationController
      skip_auth_for :index

      def index
        occupations = Occupation.order(:position).select(:id, :name, :code)
        render json: { occupations: occupations }
      end
    end
  end
end
