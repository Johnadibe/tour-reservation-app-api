FactoryBot.define do
    factory :tour do
      sequence(:name) { |n| "Tour #{n}" }
      sequence(:city) { |n| "Canada #{n}" }
      price { 245 + n.to_i }
      video { "https://www.youtube.com/watch?v=XxuPlSW4t6M&list=PLCawOXF4xaJLb9HwPWiizGBNupJszY6bR" }
      user { "2" }
      
      after(:build) do |tour|
        tour.image.attach(
            io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'dominos.png')), 
            filename: 'dominos.jpg', 
            content_type: 'image/jpeg'
        )
      end
    end
end