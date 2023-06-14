require 'rails_helper'

RSpec.describe 'Tours', type: :request do
  describe 'POST /api/v1/tours' do
    it 'creates a tour' do
      # Manually create a user
    #   user = User.create(name: 'test2', email: 'rails2@gmail.com', password: 'backend12')

    #   # Make a request to create a tour with the user's token
    #   post '/api/v1/tours', params: {
    #     tour: {
    #       name: 'Joyland',
    #       city: 'Lahore',
    #       price: 30,
    #       video: 'This is the video',
    #       image: 'This is the image',
    #       user_id: user.id
    #     }
    #   },
    #   headers: { 'Authorization' => "Bearer #{user.token}" }

    #   # Assert the response and perform further assertions as needed
    #   expect(response).to have_http_status(:created)

    get '/api/v1/tours'
    expect(response).to have_http_status(:success)
      # ...
    end
  end
end
