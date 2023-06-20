require 'swagger_helper'

RSpec.describe 'Reservations', type: :request do

  include JsonWebToken
  let!(:user1) { create :user }
  let!(:access_token) { generate_token(user1) }
  let!(:Authorization) { access_token.to_s }

  # get reservations 
  path '/reservations' do
    get 'list reservations' do
      tags 'Reservations'
      produces 'application/json'
      let!(:reservation) { create :reservation }
      response '200', 'Successful' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          response = JSON.parse(response.body)
          expect(response).to_not eq([])
        end
      end
    end
  end

  path '/reservations' do
    post 'Create reservations' do
      tags 'Reservations'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: { tour_id: { type: :string }, start_end: { type: :string }, end_date: { type: :string },},
        required: %w[start_end city price des]
      }
      let(:params) do
        { name: 'Joyland', city: 'Lahore', price: 30, video: 'This is the video', des: 'Just a small place to fun',
          image: fixture_file_upload('dominos.png', 'image/png') }
      end
      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = { 'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          } }
        end
        run_test!
      end

      response(400, 'Bad Request') do
        let!(:params) { { name: 'name', city: 'Lagos' } }
        run_test!
      end
    end
  end


    scenario 'create a reservation' do
      token = json_data['token']

      post "/api/v1/reservations?token=#{token}", params: {
        reservation: {
          start_date: '12/05/2023',
          end_date: '13/07/2023'
        }
      }

      expect(response.body).not_to be_nil
    end

    scenario 'checks the request when we are not passing the token' do
      post '/api/v1/reservations', params: {
        reservation: {
          start_date: '12/05/2023',
          end_date: '13/07/2023'
        }
      }
      expect(response.status).to eq(401)
    end

    scenario 'checks the request ' do
      post '/api/v1/reservations', params: {
        tour: {
          start_date: '12/05/2023',
          end_date: '13/07/2023'
        }
      }
      expect(response).not_to have_http_status(:ok)
    end

  end

  describe 'Get /post' do
    scenario 'checking the get request' do
      get '/api/v1/reservations', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response.status).to eq(200)
    end
    scenario 'checking the get http request' do
      get '/api/v1/reservations', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response).to have_http_status(:ok)
    end
    scenario 'checking the get response' do
      get '/api/v1/reservations', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response.body).to eq('[]')
    end
end
