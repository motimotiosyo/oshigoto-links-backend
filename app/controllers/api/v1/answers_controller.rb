class Api::V1::AnswersController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: [ :update, :destroy ]

  # GET /api/v1/questions/:question_id/answers
  def index
    @answers = @question.answers.order(created_at: :desc)
    render json: { answers: @answers }
  end

  # POST /api/v1/questions/:question_id/answers
  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      render json: { answer: @answer }, status: :created
    else
      render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/questions/:question_id/answers/:id
  def update
    if @answer.update(answer_params)
      render json: { answer: @answer }
    else
      render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/questions/:question_id/answers/:id
  def destroy
    @answer.destroy
    head :no_content
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end
end
