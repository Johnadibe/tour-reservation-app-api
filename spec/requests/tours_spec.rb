require 'rails_helper'

RSpec.describe 'Tours', type: :request do
  
  describe 'POST /api/v1/tours' do
    before(:each) do
      post '/api/v1/users', params: {
        name: 'test3',
        email: 'rails3@yopmail.com',
        password: 'backend12'
      }
    end
  
    let(:json_data) { JSON.parse(response.body) }
    it 'create a tour' do
      token = json_data['token']
      puts "Token: #{token}" # Add this line for debugging

      post '/api/v1/tours', params: {
        tour: {
          name: 'Joyland',
          city: 'Lahore',
          price: 30,
          video: 'This is the video',
          image: 'This is the image'
        }
      }, headers:  { 'Authorization' => "Bearer #{json_data['token']}" }

      puts "Response: #{response.body}" # Add this line for debugging

      expect(response.body).to not_be_nil
    end
  end
end
