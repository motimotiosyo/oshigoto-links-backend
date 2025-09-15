module Api
  module V1
    class ExperiencesController < ApplicationController
      include ErrorRenderable

      before_action :set_experience, only: [ :show, :update, :destroy ]
      # before_action :authenticate_user!  # TODO: 認証機能実装後に有効化

      # GET /api/v1/experiences
      def index
        page = params[:page]&.to_i || 1
        per_page = [ params[:per_page]&.to_i || 20, 100 ].min
        sort = params[:sort] || "-created_at"

        offset = (page - 1) * per_page

        experiences = Experience.sorted_by(sort)
                      .limit(per_page)
                      .offset(offset)

        total_count = Experience.count
        total_pages = (total_count.to_f / per_page).ceil

        response.headers["X-Total-Count"] = total_count.to_s

        render json: {
          experiences: experiences.map { |experience| serialize_experience(experience) },
          pagination: {
            current_page: page,
            total_pages: total_pages,
            total_count: total_count,
            per_page: per_page
          }
        }
      end

      # GET /api/v1/experiences/1
      def show
        render json: {
          experience: serialize_experience(@experience)
        }
      end

      # POST /api/v1/experiences
      def create
        experience_params_hash = experience_params
        experience = Experience.new(experience_params_hash)

        if experience.save
          render json: {
            experience: serialize_experience(experience)
          }, status: :created
        else
          render_unprocessable_entity(
            OpenStruct.new(record: experience)
          )
        end
      end

      # PUT /api/v1/experiences/1
      def update
        experience_params_hash = experience_params

        if @experience.update(experience_params_hash)
          render json: {
            experience: serialize_experience(@experience)
          }
        else
          render_unprocessable_entity(
            OpenStruct.new(record: @experience)
          )
        end
      end

      # DELETE /api/v1/experiences/1
      def destroy
        @experience.destroy
        head :no_content
      end

      private

      def set_experience
        @experience = Experience.find(params[:id])
      end

      def experience_params
        params.require(:experience).permit(:title, :body, tags: [])
      end

      def serialize_experience(experience)
        {
          id: experience.id,
          title: experience.title,
          body: experience.body,
          tags: experience.tags || [],
          created_at: experience.created_at.iso8601,
          updated_at: experience.updated_at.iso8601
        }
      end

      # TODO: JWT認証実装後に有効化
      def authenticate_user!
        # 仮実装: 常にtrueを返す（開発用）
        true

        # 実装予定:
        # token = request.headers['Authorization']&.split(' ')&.last
        # decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
        # @current_user = User.find(decoded_token[0]['user_id'])
        # rescue JWT::DecodeError
        #   render_unauthorized
      end
    end
  end
end
