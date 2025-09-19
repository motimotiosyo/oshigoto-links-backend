# app/controllers/api/v1/question_likes_controller.rb
class Api::V1::QuestionLikesController < ApplicationController
  before_action :set_question

  # POST /api/v1/questions/:question_id/question_like
  def create
    uid = params[:user_id]
    like = QuestionLike.find_by(user_id: uid, question_id: @question.id)
    status = like ? :ok : :created
    like ||= QuestionLike.create!(user_id: uid, question: @question)

    render json: {
      liked: true,
      likes_count: @question.reload.likes_count
    }, status: status
  rescue ActiveRecord::RecordInvalid
    render json: { errors: ["User must exist"] }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotUnique
    render json: {
      liked: true,
      likes_count: @question.reload.likes_count
    }, status: :ok
  end

  # DELETE /api/v1/questions/:question_id/question_like
  def destroy
    uid = params[:user_id]
    if (like = QuestionLike.find_by(user_id: uid, question_id: @question.id))
      like.destroy
    end
    head :no_content
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
