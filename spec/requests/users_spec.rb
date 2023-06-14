require 'rails_helper'

RSpec.describe Tour, type: :request do
  describe 'Post /create' do
    before(:each) do
       post '/api/v1/users', params: {
            "name": "test2",
            "email": "rails1@yopmail.com",
            "password": "backend12",
        }
    end
    let(:json_data) { JSON.parse(response.body) }
    scenario 'creates a user' do
        expect(response.status).to eq(200)
        expect(response).to have_http_status(:ok)
        # json = JSON.parse(response.body).deep_symbolize_keys
    end
    scenario 'checks the user body' do
        expect(json_data['data']['name']).to eq('test2')
        expect(json_data['data']['email']).to eq('rails1@yopmail.com')
        expect(json_data['token']).not_to be_nil
    end

  end
end