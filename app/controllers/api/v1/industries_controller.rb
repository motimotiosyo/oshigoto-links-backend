module Api
  module V1
    class IndustriesController < ApplicationController
      skip_auth_for :index

      def index
        industries = Industry.order(:position).select(:id, :name, :code)
        render json: { industries: industries }
      end
    end
  end
end
