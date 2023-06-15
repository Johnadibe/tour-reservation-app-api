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
          name: "Joyland",
          city: "Lahore",
          price: 30,
          video: "This is the video",
          image: "This is the image"
        }
      }
      
      
      expect(response.body).not_to be_nil
    end
    scenario 'checks the request when we are not passing the token' do
      post "/api/v1/tours", params: {
        tour: {
          name: "Joyland",
          city: "Lahore",
          price: 30,
          video: "This is the video",
          image: "This is the image"
        }
      }
      expect(response.status).to eq(401)
    end    
    scenario 'checks the request ' do
      post "/api/v1/tours", params: {
        tour: {
          name: "Joyland",
          city: "Lahore",
          price: 30,
          video: "This is the video",
          image: "This is the image"
        }
      }
      expect(response).not_to have_http_status(:ok)
    end    
  end
end
