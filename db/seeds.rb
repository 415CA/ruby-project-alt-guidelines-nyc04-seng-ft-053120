Groomer.destroy_all
Service.destroy_all
Owner.destroy_all
Dog.destroy_all
Appointment.destroy_all

5.times do
    Groomer.create(name: Faker::Name.name)
end

5.times do
    Owner.create(name: Faker::Name.name)
end

5.times do
    Dog.create(name: Faker::Creature::Dog.name)
end

2.times do
    Service.create(name: Faker::App.name, price: rand(10..50))
end

3.times do
  Appointment.create(date: "July, 4", time: "1:00PM", owner_id: rand(2..5), groomer_id: rand(2..5), dog_id: rand(2..5), service_id: rand(2..5))
end

# o = Owner.first
# g = Groomer.first
# s = Service.first
# d = Dog.first
# a = Appointment.create(date: "July, 4", time: "1:00PM", owner_id: o.id, groomer_id: g.id, dog_id: d.id, service_id: s.id)
