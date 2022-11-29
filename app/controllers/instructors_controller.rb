class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params 
        params.permit(:name, :id)
    end

    def record_not_found(error)
        # byebug
        render json: {errors: {error.model => "Not Found"}}, status: :not_found
    end

    def unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
