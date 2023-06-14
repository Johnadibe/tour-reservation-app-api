require 'rails_helper'

RSpec.describe 'Tours', type: :request do
    let! (:user) {User.create(name: 'test2', email: 'rail1@yopmail.com', password: 'backend12')} 
    describe 'POST /api/v1/tours' do
    it 'creates a tour' do
    get '/api/v1/tours'
    expect(response).to have_http_status(:success)
    expect(response.status).to eq(200)
    expect(response).to have_http_status(:ok)
    end
    it 'create a tour ' do
        post '/api/v1/tours', params: {
            tour: {
                name: 'Joyland',
                city: 'Lahore',
                price: 30,
                video: 'This is the video',
                image: 'https://picsum.photos/200/300',
                user_id: user.id
            }, headers: { 'Authorization' => "Bearer #{user.token}" }
        }

        p user.token

        expect(response.status).to eq(201)
    end
  end
end
