require 'rails_helper'

RSpec.describe 'Tours', type: :request do
  before(:each) do
    post '/api/v1/users', params: {
      name: 'test3',
      email: 'rails3@yopmail.com',
      password: 'backend12'
    }
  end

  let(:json_data) { JSON.parse(response.body) }

  describe 'POST /api/v1/tours' do
    scenario 'create a tour' do
      token = json_data['token']

      post "/api/v1/tours?token=#{token}", params: {
        tour: {
          name: 'Joyland',
          city: 'Lahore',
          price: 30,
          video: 'This is the video',
          image: 'This is the image',
          des: 'Just a small place to fun'
        }
      }

      expect(response.body).not_to be_nil
    end

    path '/tours' do
      get 'list tours' do
        tags 'Tours'
        produces "application/json"
        response '201', 'user created' do
          # let! (:user) {User.create(username: 'mp', authentication_token: 'mptoken')}
          # run_test!
          scenario 'checking the get request' do
            get '/api/v1/tours', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
            expect(response.status).to eq(200)
          end
          end
        end
  
        response '422', 'invalid request' do
          let(:user) { { username: 'foo' } }
          run_test!
        end
      end
    end
    
    scenario 'checks the request ' do
      post '/api/v1/tours', params: {
        tour: {
          name: 'Joyland',
          city: 'Lahore',
          price: 30,
          video: 'This is the video',
          image: 'This is the image'
        }
      }
      expect(response).not_to have_http_status(:ok)
    end
  end
  describe 'Get /post' do
    scenario 'checking the get request' do
      get '/api/v1/tours', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response.status).to eq(200)
    end
    scenario 'checking the get http request' do
      get '/api/v1/tours', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response).to have_http_status(:ok)
    end
    scenario 'checking the get responce' do
      get '/api/v1/tours', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      expect(response.body).to eq('[]')
    end
  end
end
