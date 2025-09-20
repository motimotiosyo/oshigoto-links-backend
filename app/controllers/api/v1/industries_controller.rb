class Api::V1::IndustriesController < ApplicationController
  def index
    industries = Industry.includes(:industry_categories)
    render json: industries.as_json(include: :industry_categories)
  end
end
