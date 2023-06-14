require 'rails_helper'

RSpec.describe 'Tours', type: :request do
  describe 'POST /api/v1/tours' do
    before(:example) do
      #   post '/api/v1/users', params: {
      #     name: 'test2',
      #     email: 'rails1@yopmail.com',
      #     password: 'backend12'
      #   }
      get 'api/v1/users', params: {
        email: 'rails1@yopmail.com',
        password: 'backend12'
      }
    end
    let(:json_data) { JSON.parse(response.body) }
    it 'create a tour ' do
      post '/api/v1/tours', params: {
        tour: {
          name: 'Joyland',
          city: 'Lahore',
          price: 30,
          video: 'This is the video',
          image: 'https://picsum.photos/200/300'
        }, headers: { 'Authorization' => "Bearer #{json_data['token']}" }
      }

      expect(response.status).to eq(200)
    end
  end
end
