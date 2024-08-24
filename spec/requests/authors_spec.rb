require 'swagger_helper'

RSpec.describe 'Authors endpoints', type: :request do
  path '/authors' do
    get 'Retrieves all authors' do
      tags 'Authors'
      produces 'application/json'

      response '200', 'authors found' do
        schema(
          type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: %w[id name created_at updated_at]
          }
        )

        let!(:authors) { create_list(:author, 2) }

        run_test!
      end
    end

    post 'Creates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter(
        name: :author,
        in: :body,
        schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: [ 'name' ]
        }
      )

      response '201', 'author created' do
        let(:author) { { name: 'New Author' } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:author) { { name: '' } }

        run_test!
      end
    end
  end

  path '/authors/{id}' do
    get 'Retrieves an author' do
      tags 'Authors'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'author found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: %w[id name created_at updated_at]
        )

        let(:id) { create(:author).id }

        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'fake_id' }

        run_test!
      end
    end

    put 'Updates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter(
        name: :author,
        in: :body,
        schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: [ 'name' ]
        }
      )

      response '200', 'author updated' do
        let(:id) { create(:author).id }
        let(:author) { { name: 'New Name' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:author).id }
        let(:author) { { name: '' } }

        run_test!
      end
    end

    delete 'Deletes an author' do
      tags 'Authors'
      parameter name: :id, in: :path, type: :integer

      response '204', 'author deleted' do
        let(:id) { create(:author).id }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'fake_id' }
        run_test!
      end
    end
  end
end
