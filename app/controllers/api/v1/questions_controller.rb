# 構造・共通の処理
module Api
  module V1
    class QuestionsController < ApplicationController
      include ErrorRenderable
      before_action :set_question, only: %i[ show update destroy ]

      # 絞り込み対応。並び替えはモデル側の”sorted_by”に任せる
      def index
        page     = params[:page]&.to_i || 1
        per_page = [ params[:per_page]&.to_i || 20, 100 ].min
        sort     = params[:sort] || "-created_at"

        scope = Question.all
        scope = scope.where(status_label: params[:status_label]) if params[:status_label].present?
        scope = scope.where(industry_id: params[:industry_id])   if params[:industry_id].present?
        scope = scope.where(occupation_id: params[:occupation_id]) if params[:occupation_id].present?
        scope = scope.sorted_by(sort)

        total   = scope.count
        records = scope.offset((page - 1) * per_page).limit(per_page)

        response.headers["X-Total-Count"] = total.to_s

        render json: {
          questions: records.map { |q| serialize(q) },
          pagination: {
            current_page: page,
            total_pages: (total.to_f / per_page).ceil,
            total_count: total,
            per_page: per_page
          }
        }
      end

      # GET /api/v1/questions/:id
      def show
        render json: { question: serialize(@question) }
      end

      # POST /api/v1/questions
      def create
        q = Question.new(question_params)
        if q.save
          render json: { question: serialize(q) }, status: :created
        else
          render_unprocessable_entity(OpenStruct.new(record: q))
        end
      end

      # PATCH/PUT /api/v1/questions/:id  #更新（update）
      def update
        if @question.update(question_params)
          render json: { question: serialize(@question) }
        else
          render_unprocessable_entity(OpenStruct.new(record: @question))
        end
      end

      # DELETE /api/v1/questions/:id  #削除（destroy）
      def destroy
        @question.destroy
        head :no_content
      end

      # 本人の投稿のみ編集/削除可の権限チェックは後で

      private

      def set_question
        @question = Question.find(params[:id])
      end

      def question_params
        params.require(:question).permit(
          :title, :body, :status_label,
          :industry_id, :occupation_id
        )
      end

      # レスポンスに含めるキーを統一。
      def serialize(q)
        {
          id: q.id,
          title: q.title,
          body: q.body,
          status_label: q.status_label,
          accepted_answer_id: q.accepted_answer_id,
          answers_count: q.answers_count,
          likes_count: q.likes_count,
          comments_count: q.comments_count,
          last_answered_at: q.last_answered_at&.iso8601,
          user_id: q.user_id,
          industry_id: q.industry_id,
          occupation_id: q.occupation_id,
          created_at: q.created_at.iso8601,
          updated_at: q.updated_at.iso8601
        }
      end
    end
  end
end
