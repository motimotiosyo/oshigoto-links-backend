module Api
  module V1
    class OccupationsController < ApplicationController
      include ErrorRenderable

      # GET /api/v1/occupations
      def index
        occupations = Occupation.includes(:occupation_categories)
                               .order(:position, :name)

        render json: {
          occupations: occupations.map { |occupation| serialize_occupation(occupation) }
        }
      end

      private

      def serialize_occupation(occupation)
        {
          id: occupation.id,
          name: occupation.name,
          code: occupation.code,
          position: occupation.position,
          categories: occupation.occupation_categories.order(:position, :name).map do |category|
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
