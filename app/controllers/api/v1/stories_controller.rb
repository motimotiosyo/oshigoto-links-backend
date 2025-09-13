module Api
  module V1
    class StoriesController < ApplicationController
      include ErrorRenderable
      
      before_action :set_story, only: [:show, :update, :destroy]
      before_action :authenticate_user!  # TODO: 認証機能実装後に有効化
      
      # GET /api/v1/stories
      def index
        page = params[:page]&.to_i || 1
        per_page = [params[:per_page]&.to_i || 20, 100].min
        sort = params[:sort] || '-created_at'
        
        stories = Story.sorted_by(sort)
                      .page(page)
                      .per(per_page)
        
        total_count = Story.count
        total_pages = (total_count.to_f / per_page).ceil
        
        response.headers['X-Total-Count'] = total_count.to_s
        
        render json: {
          stories: stories.map { |story| serialize_story(story) },
          pagination: {
            current_page: page,
            total_pages: total_pages,
            total_count: total_count,
            per_page: per_page
          }
        }
      end
      
      # GET /api/v1/stories/1
      def show
        render json: {
          story: serialize_story(@story)
        }
      end
      
      # POST /api/v1/stories
      def create
        story_params_hash = story_params
        story = Story.new(story_params_hash)
        
        if story.save
          render json: {
            story: serialize_story(story)
          }, status: :created
        else
          render_unprocessable_entity(
            OpenStruct.new(record: story)
          )
        end
      end
      
      # PUT /api/v1/stories/1
      def update
        story_params_hash = story_params
        
        if @story.update(story_params_hash)
          render json: {
            story: serialize_story(@story)
          }
        else
          render_unprocessable_entity(
            OpenStruct.new(record: @story)
          )
        end
      end
      
      # DELETE /api/v1/stories/1
      def destroy
        @story.destroy
        head :no_content
      end
      
      private
      
      def set_story
        @story = Story.find(params[:id])
      end
      
      def story_params
        params.require(:story).permit(:title, :body, tags: [])
      end
      
      def serialize_story(story)
        {
          id: story.id,
          title: story.title,
          body: story.body,
          tags: story.tags || [],
          created_at: story.created_at.iso8601,
          updated_at: story.updated_at.iso8601
        }
      end
      
      # TODO: JWT認証実装後に有効化
      def authenticate_user!
        # 仮実装: 常にtrueを返す（開発用）
        return true
        
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