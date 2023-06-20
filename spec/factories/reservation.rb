FactoryBot.define do
    factory :reservation do
      start_end "12-02-2023" 
      end_date "13-04-2023"
      user
      tour
    end
  end