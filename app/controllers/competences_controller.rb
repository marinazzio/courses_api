class CompetencesController < ApplicationController
  before_action :set_competence, only: [:show, :update, :destroy]

  def index
    @competences = Competence.all

    render json: @competences
  end

  def create
    @competence = Competence.new(competence_params)

    if @competence.save
      render json: @competence, status: :created
    else
      render json: @competence.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @competence
  end

  def update
    if @competence.update(competence_params)
      render json: @competence, status: :ok
    else
      render json: @competence.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @competence.destroy

    render json: { message: 'Competence deleted' }, status: :no_content
  end

  private

  def set_competence
    @competence = Competence.find(params[:id])
  end

  def competence_params
    params.require(:competence).permit(:title)
  end
end
