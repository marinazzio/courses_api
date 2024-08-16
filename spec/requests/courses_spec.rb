require 'swagger_helper'

RSpec.describe 'Courses endpoints', type: :request do
  path '/courses' do
    get 'Retrieves all courses' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'courses found' do
        schema(
          type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: %w[id name created_at updated_at]
          }
        )

        run_test!
      end
    end

    post 'Creates a course' do
      tags 'Courses'
      consumes 'application/json'

      parameter(
        name: :course,
        in: :body,
        schema: {
          type: :object,
          properties: {
            title: { type: :string },
            author_id: { type: :integer }
          },
          required: ['title']
        }
      )

      response '201', 'course created' do
        let!(:author) { Author.create(name: 'New Author') }
        let(:course) { { title: 'New Course', author_id: author.id } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:course) { { title: '' } }
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    get 'Retrieves a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'course found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            tiitle: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: %w[id title created_at updated_at]
        )

        let(:id) { create(:course).id }
        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'fake_id' }
        run_test!
      end
    end

    put 'Updates a course' do
      tags 'Courses'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter(
        name: :course,
        in: :body,
        schema: {
          type: :object,
          properties: {
            title: { type: :string }
          },
          required: ['title']
        }
      )

      response '200', 'course updated' do
        let(:id) { create(:course).id }
        let(:course) { { title: 'Updated Course' } }

        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'fake_id' }
        let(:course) { { title: 'Updated Course' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:course).id }
        let(:course) { { title: '' } }

        run_test!
      end
    end

    delete 'Deletes a course' do
      tags 'Courses'

      parameter name: :id, in: :path, type: :integer

      response '204', 'course deleted' do
        let(:id) { create(:course).id }
        run_test!
      end

      response '404', 'course not found' do
        let(:id) { 'fake_id' }
        run_test!
      end
    end
  end
end
