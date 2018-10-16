20.times do
  Hotel.create!(name: Faker::Restaurant.name, 
                address: Faker::Address.street_address,
                phone_number: Faker::PhoneNumber.cell_phone, 
                service: Faker::Restaurant.description)
end