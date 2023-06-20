require 'swagger_helper'

RSpec.describe "User", type: :request do
  let!(:user) { create :user }
  include ApplicationController
  let!(:access_token) { user.generate_token }
  let!(:Authorization) { access_token.to_s }
  # create user 
  path "/users" do
    post("Create user") do
      tags 'Users'
      consumes 'application/json'
      produces "application/json"
      parameter name: :user, in: :body, schema:{
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'name', 'email', 'password' ]
      }
      response '201', 'user created' do
        let(:user) { { name: 'test2', email: 'rails2@yopmail.com', password: 'backend12' } }

        run_test! do |response| 
          data = JSON.parse(response.body)
          expect(data['data']['name']).to eq('test2')
          expect(data['data']['email']).to eq('rails2@yopmail.com')
          expect(data['token']).not_to be_nil
        end
      end
    end
  end

  # login user 
  path "/login" do
    post("Authenticate user") do
      tags "Users"
      consumes 'application/json'
      produces "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }
      response '200', 'user authenticated' do
        # login credentials
        let(:user) { { email: 'test2@gmail.com', password: '123456' } }

        run_test! do |response| 
          data = JSON.parse(response.body)
          expect(data['token']).not_to be_nil
        end
      end

      response '401', 'Unauthorized' do
        # login credentials
        let(:user) { { email: 'wrongemail', password: 'invalidpassord' } }

        run_test! do |response| 
          data = JSON.parse(response.body)
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('error')
        end
      end
    end
  end

  # fetch user by id
  path "/users/:id" do
    get("Get user by id") do
      produces 'application/json'
      tags "Users"
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :Authorization, in: :header, type: :string
      response(200, 'successful') do
        let(:id) { user.id }
        
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.id).to eq(user.id)
        end
      end
    end
  end

  # scenario '/api/v1/users/:id' do
  #   get "/api/v1/users/#{json_data['data']['id']}", headers: { 'Authorization' => "Bearer #{json_data['token']}" }
  #   expect(response.status).to eq(200)
  #   expect(response).to have_http_status(:ok)
  # end

  # scenario '/api/v1/users/' do
  #   get '/api/v1/users', headers: { 'Authorization' => "Bearer #{json_data['token']}" }
  #   expect(response.status).to eq(200)
  #   expect(response).to have_http_status(:ok)
  #   expect(response.body.length).not_to be_nil
  # end
end
