Hotel.create!(name: "Bach Khoa Hotel", address: "Khách sạn A25 Bạch Mai",
phone_number: Faker::PhoneNumber.cell_phone, service: Faker::Restaurant.description)
Hotel.create!(name: "Xã Đàn Hotel", address: "Saigon Sun Hotel Xã Đàn",
phone_number: Faker::PhoneNumber.cell_phone, service: Faker::Restaurant.description)
20.times do
  Hotel.create!(name: Faker::Restaurant.name, address: Faker::Address.full_address,
phone_number: Faker::PhoneNumber.cell_phone, service: Faker::Restaurant.description)
end

users = User.order(:created_at).take(6)

50.times do
  review = Faker::Restaurant.description
  HotelReview.create!(hotel_id: rand(1..10), review: review)
  # users.each {|user| user.hotel_reviews.create!(hotel_id: rand(1..10), review: review)}
end