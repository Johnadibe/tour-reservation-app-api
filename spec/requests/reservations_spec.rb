require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  before(:each) do
    post '/api/v1/users', params: {
      name: 'test3',
      email: 'rails3@yopmail.com',
      password: 'backend12'
    }
  end

  let(:json_data) { JSON.parse(response.body) }

  describe 'POST /api/v1/reservations' do
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
end
