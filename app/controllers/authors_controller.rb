class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]

  def index
    @authors = Author.all

    render json: @authors, status: :ok
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render json: @author, status: :created
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @author, status: :ok
  end

  def update
    if @author.update(author_params)
      render json: @author, status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Author.transaction do
      deleting_author_courses = Course.where(author_id: @author.id)

      deleting_author_courses.each do |course|
        course.update(author_id: new_author.id)
      end

      @author.destroy
    end

    render json: { message: 'Author deleted' }, status: :no_content
  end

  private

  def new_author
    @new_author ||=
      Author
        .where.not(id: @author.id)
        .first
  end

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
