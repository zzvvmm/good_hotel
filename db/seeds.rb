# 20.times do
#   User.create!(name: 'Admin',
#              email: "admin@hotel.com",
#              password: "123456",
#              password_confirmation: "123456",
#              is_admin: true,
#              is_actived: true,
#              activated_at: Time.zone.now)

# 99.times do |n|
#   name  = Faker::Name.name
#   email = "user#{n + 1}@hotel.com"
#   password = "123456"
#   User.create!(name:  name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                is_actived: true,
#                activated_at: Time.zone.now)
# end
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
