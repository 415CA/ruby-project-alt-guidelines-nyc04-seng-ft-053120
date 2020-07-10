# frozen_string_literal: true

# Appointment Class Methods

class Appointment < ActiveRecord::Base
  attr_accessor :prompt, :user

  has_many :owners
  has_many :groomers
  has_many :dogs
  has_many :services

  def print_owners
    owners = Owner.all.select { |owner| owner.appointments.include?(self) || owner.appointment_id == id }
    owners.map { |owner_instance| owner_instance.name.to_s }.join(' | ')
  end

  def print_dogs
    dogs = Dog.all.select { |dog| dog.appointments.include?(self) || dog.appointment_id == id }
    dogs.map { |dog_instance| dog_instance.name.to_s }.join(' | ')
  end

  def print_groomers
    groomers = Groomer.all.select { |groomer| groomer.appointments.include?(self) || groomer.appointment_id == id }
    groomers.map { |groomer_instance| groomer_instance.name.to_s }.join(' | ')
  end

  def print_services
    services.map { |service_instance| "#{service_instance[:name]}: $#{service_instance[:price]}" }.join(' | ')
  end

  def print_time
    time.to_s
  end

  def print_date
    date.to_s
  end

  def total_service_price
    services.reduce(0) { |sum, service_instance| sum + service_instance[:price] }
  end

  def print_appointment
    puts "Appointment: #{id}"
    puts "Date: #{print_date}"
    puts "Time: #{print_time}"
    puts "Owner: #{print_owners}"
    puts "Dog: #{print_dogs}"
    puts "Groomer: #{print_groomers}"
    puts "Services: #{print_services}"
    puts "Total: $#{total_service_price}"
    puts '--------------------------------------------------------------------'
  end

  def add_groomer(groomer)
    groomers << groomer
    self.groomer_id = groomer.id
  end

  def add_service(service)
    services << service
    self.service_id = service.id
  end

  def add_owner(owner)
    owners << owner
    self.owner_id = owner.id
  end

  def add_dog(dog)
    dogs << dog
    self.dog_id = dog.id
  end

  def change_date(date)
    self[:date] = date
  end

  def change_time(time)
    self[:time] = time
  end
end
