# frozen_string_literal: true

Groomer.destroy_all
Service.destroy_all
Owner.destroy_all
Dog.destroy_all
Appointment.destroy_all

melissa = Owner.create(name: 'Melissa')
mike = Owner.create(name: 'Mike')

caitlin = Groomer.create(name: 'Caitlin')
chris = Groomer.create(name: 'Chris')

rocco = Dog.create(name: 'Rocco')
rex = Dog.create(name: 'Rex')

hair = Service.create(name: 'Hair', price: 10)
nails = Service.create(name: 'Nails', price: 10)
wash = Service.create(name: 'Wash', price: 10)

Appointment.create(date: 'July, 24', time: '1:00PM', owner_id: melissa.id, groomer_id: caitlin.id, dog_id: rocco.id, service_id: hair.id)
Appointment.create(date: 'August, 10', time: '2:00PM', owner_id: melissa.id, groomer_id: caitlin.id, dog_id: rocco.id, service_id: nails.id)
Appointment.create(date: 'August, 20', time: '3:00PM', owner_id: mike.id, groomer_id: chris.id, dog_id: rex.id, service_id: hair.id)
Appointment.create(date: 'September, 6', time: '3:40PM', owner_id: mike.id, groomer_id: chris.id, dog_id: rex.id, service_id: wash.id)

melissa.dogs << rocco
mike.dogs << rex

hair.groomers << caitlin
nails.groomers << chris
wash.groomers << chris

# 5.times do
#   Groomer.create(name: Faker::Name.name)
# end
# 
# 5.times do
#   Owner.create(name: Faker::Name.name)
# end
# 
# 5.times do
#   Dog.create(name: Faker::Creature::Dog.name)
# end
# 
# 5.times do
#   Service.create(name: Faker::App.name, price: rand(10..50))
# end
# 
# 5.times do
#   Appointment.create(date: 'July, 4', time: '1:00PM', owner_id: rand(1..5), groomer_id: rand(1..5), dog_id: rand(1..5), service_id: rand(1..5))
# end
# 
# Appointment.create(date: 'July, 4', time: '1:00PM', owner_id: 1, groomer_id: 1, dog_id: 1, service_id: 1)
# 
