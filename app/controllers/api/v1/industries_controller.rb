module Api
  module V1
    class IndustriesController < ApplicationController
      include ErrorRenderable

      # GET /api/v1/industries
      def index
        industries = Industry.includes(:industry_categories)
                            .order(:position, :name)

        render json: {
          industries: industries.map { |industry| serialize_industry(industry) }
        }
      end

      private

      def serialize_industry(industry)
        {
          id: industry.id,
          name: industry.name,
          code: industry.code,
          position: industry.position,
          categories: industry.industry_categories.order(:position, :name).map do |category|
            {
              id: category.id,
              name: category.name,
              code: category.code,
              position: category.position
            }
          end
        }
      end
    end
  end
end
