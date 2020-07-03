Groomer.destroy_all
Service.destroy_all
Owner.destroy_all
Dog.destroy_all

50.times do
    Groomer.create(name: Faker::Name.name)
end

50.times do
    Owner.create(name: Faker::Name.name)
end

50.times do
    Dog.create(name: Faker::Creature::Dog.name)
end

20.times do
    Service.create(service_type: Faker::App.name, service_price: rand(10..50))
end