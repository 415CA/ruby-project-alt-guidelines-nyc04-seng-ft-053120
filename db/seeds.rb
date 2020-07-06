# frozen_string_literal: true

Groomer.destroy_all
Service.destroy_all
Owner.destroy_all
Dog.destroy_all
Appointment.destroy_all

max = Owner.create(name: 'Max')
melissa = Owner.create(name: 'Melissa')
mike = Owner.create(name: 'Mike')
margaret = Owner.create(name: 'Margaret')

caitlin = Groomer.create(name: 'Caitlin')
chris = Groomer.create(name: 'Chris')

rocco = Dog.create(name: 'Rocco')
rex = Dog.create(name: 'Rex')
reggie = Dog.create(name: 'Reggie')
rachel = Dog.create(name: 'Rachel')

hair = Service.create(name: 'Hair', price: 10)
nails = Service.create(name: 'Nails', price: 10)
wash = Service.create(name: 'Wash', price: 10)

Appointment.create(date: 'July, 4', time: '1:00PM', owner_id: max.id, groomer_id: caitlin.id, dog_id: rocco.id, service_id: hair.id)
Appointment.create(date: 'July, 4', time: '1:20PM', owner_id: max.id, groomer_id: caitlin.id, dog_id: rocco.id, service_id: nails.id)
Appointment.create(date: 'July, 4', time: '1:40PM', owner_id: max.id, groomer_id: caitlin.id, dog_id: rocco.id, service_id: wash.id)
Appointment.create(date: 'July, 4', time: '2:00PM', owner_id: melissa.id, groomer_id: caitlin.id, dog_id: rex.id, service_id: hair.id)
Appointment.create(date: 'July, 4', time: '2:20PM', owner_id: melissa.id, groomer_id: caitlin.id, dog_id: rex.id, service_id: nails.id)
Appointment.create(date: 'July, 4', time: '2:40PM', owner_id: melissa.id, groomer_id: caitlin.id, dog_id: rex.id, service_id: wash.id)
Appointment.create(date: 'July, 4', time: '3:00PM', owner_id: mike.id, groomer_id: chris.id, dog_id: reggie.id, service_id: hair.id)
Appointment.create(date: 'July, 4', time: '3:20PM', owner_id: mike.id, groomer_id: chris.id, dog_id: reggie.id, service_id: nails.id)
Appointment.create(date: 'July, 4', time: '3:40PM', owner_id: mike.id, groomer_id: chris.id, dog_id: reggie.id, service_id: wash.id)
Appointment.create(date: 'July, 4', time: '3:40PM', owner_id: margaret.id, groomer_id: chris.id, dog_id: rachel.id, service_id: hair.id)
Appointment.create(date: 'July, 4', time: '3:40PM', owner_id: margaret.id, groomer_id: chris.id, dog_id: rachel.id, service_id: nails.id)
Appointment.create(date: 'July, 4', time: '3:40PM', owner_id: margaret.id, groomer_id: chris.id, dog_id: rachel.id, service_id: wash.id)

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
 o = Owner.first
 g = Groomer.first
 s = Service.first
 d = Dog.first
 
 o.dogs << d
 d.owners << o
 g.services << s
 g.services << Service.all[1]
 g.services << Service.all[2]
 s.groomers << g
 a = Appointment.create(date: 'July, 4', time: '1:00PM', owner_id: o.id, groomer_id: g.id, dog_id: d.id, service_id: s.id)
