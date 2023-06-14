# require 'rails_helper'

# RSpec.describe 'Reservations', type: :request do
#   describe 'GET /index' do
#     it 'returns http success' do
#       get '/reservations/index'
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe 'GET /show' do
#     it 'returns http success' do
#       get '/reservations/show'
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe 'GET /create' do
#     it 'returns http success' do
#       get '/reservations/create'
#       expect(response).to have_http_status(:success)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  describe 'POST /api/v1/reservations' do
    it 'creates a reservation with the authenticated user' do
      # Manually create a user
      user = User.create(name: 'test2', email: 'rails2@gmail.com', password: 'backend12')
      tour = Tour.create(name: 'Obudu tour', city: 'Ibom', price: 245.00, video: 'Do it now or die regretting',
                         image: "This is the image" ,user_id: user.id)

      # Make a request to create a reservation with the user's token
      post '/api/v1/reservations', params: { reservation:{
        "start_end": "2012-12-20",
        "end_date": "20013-03-20",
        "tour_id": 1
    } },
                                  headers: { 'Authorization' => "Bearer #{user.token}" }

      # Assert the response and perform further assertions as needed
      expect(response).to have_http_status(:created)
      # ...
    end
  end
end
