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

10.times do
  Appointment.create(groomers_id: rand(1..50), services_id: rand(1..20), owners_id: rand(1..50),date: Faker::Date.in_date_period(year: 2020, month: 7), time: Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :afternoon, format: :short)  )
end