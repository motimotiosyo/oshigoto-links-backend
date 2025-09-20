class Api::V1::OccupationsController < ApplicationController
  def index
    occupations = Occupation.includes(:occupation_categories)
    render json: occupations.as_json(include: :occupation_categories)
  end
end
