class Api::V1::AnswerLikesController < ApplicationController
  before_action :set_answer

  # POST /api/v1/answers/:answer_id/answer_like
  def create
    uid = params[:user_id]
    like = AnswerLike.find_by(user_id: uid, answer_id: @answer.id)
    status = like ? :ok : :created
    like ||= AnswerLike.create!(user_id: uid, answer: @answer)

    render json: {
      liked: true,
      likes_count: @answer.reload.likes_count
    }, status: status
  rescue ActiveRecord::RecordInvalid
    render json: { errors: [ "User must exist" ] }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotUnique
    render json: {
      liked: true,
      likes_count: @answer.reload.likes_count
    }, status: :ok
  end

  # DELETE /api/v1/answers/:answer_id/answer_like
  def destroy
    uid = params[:user_id]
    if (like = AnswerLike.find_by(user_id: uid, answer_id: @answer.id))
      like.destroy
    end
    head :no_content
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end
end
