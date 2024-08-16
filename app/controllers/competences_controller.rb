class CompetencesController < ApplicationController
  def index
    @competences = Competence.all

    render json: @competences
  end
end
