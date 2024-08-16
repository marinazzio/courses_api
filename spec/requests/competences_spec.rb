require 'swagger_helper'

RSpec.describe 'Competences endpoints', type: :request do
  path '/competences' do
    get 'Retrieves all competences' do
      tags 'Competences'
      produces 'application/json'

      response '200', 'competences found' do
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
            required: %w[id title created_at updated_at]
          }
        )

        let!(:competences) { create_list(:competence, 2) }

        run_test!
      end
    end

    post 'Creates a competence' do
      tags 'Competences'
      consumes 'application/json'

      parameter(
        name: :competence,
        in: :body,
        schema: {
          type: :object,
          properties: {
            title: { type: :string }
          },
          required: ['title']
        }
      )

      response '201', 'competence created' do
        let(:competence) { { title: 'New Competence' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:competence) { { title: '' } }
        run_test!
      end
    end
  end

  path '/competences/{id}' do
    get 'Retrieves a competence' do
      tags 'Competences'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer

      response '200', 'competence found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: %w[id title created_at updated_at]
        )

        let(:id) { create(:competence).id }
        run_test!
      end

      response '404', 'competence not found' do
        let(:id) { 'fake_id' }
        run_test!
      end
    end

    put 'Updates a competence' do
      tags 'Competences'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      parameter(
        name: :competence,
        in: :body,
        schema: {
          type: :object,
          properties: {
            title: { type: :string }
          },
          required: ['title']
        }
      )

      let(:id) { create(:competence).id }

      response '200', 'competence updated' do
        let(:competence) { { title: 'Updated Competence' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:competence) { { title: '' } }
        run_test!
      end
    end

    delete 'Deletes a competence' do
      tags 'Competences'

      parameter name: :id, in: :path, type: :integer

      response '204', 'competence deleted' do
        let(:id) { create(:competence).id }
        run_test!
      end

      response '404', 'competence not found' do
        let(:id) { 'fake_id' }
        run_test!
      end
    end
  end
end
