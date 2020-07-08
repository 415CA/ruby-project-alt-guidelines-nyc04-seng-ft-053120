# frozen_string_literal: true

# Appointment Class Methods

class Appointment < ActiveRecord::Base
  attr_accessor :prompt, :user

  has_many :owners
  has_many :groomers
  has_many :dogs
  has_many :services

  def print_owners
    self.owners.map { |owner_instance| "#{owner_instance.name}" }.join(" | ")
  end

  def print_dogs
    self.dogs.map { |dog_instance| "#{dog_instance.name}" }.join(" | ")
  end

  def print_groomers
    self.groomers.map { |groomer_instance| "#{groomer_instance.name}"}.join(" | ")
  end

  def print_services
    self.services.map { |service_instance| "#{service_instance[:name]}: $#{service_instance[:price]}"}.join(" | ")
  end

  def print_time
    "#{self.time}"
  end

  def print_date
    "#{self.date}"
  end
  

  def total_service_price
    self.services.reduce(0){ |sum, service_instance| sum + service_instance[:price] }
  end

  def print_appointment
    puts "Appointment: #{self.id}"
    puts "Date: #{print_date}"
    puts "Time: #{print_time}"
    puts "Owner: #{print_owners}"
    puts "Dog: #{print_dogs}"
    puts "Groomer: #{print_groomers}"
    puts "Services: #{print_services}"
    puts "Total: $#{total_service_price}"
    puts "--------------------------------------------------------------------"
  end

  def add_groomer(groomer)
    self.groomers << groomer
    self.groomer_id = groomer.id
  end

  def add_service(service)
    self.services << service
    self.service_id = service.id
  end

  def add_owner(owner)
    self.owners << owner
    self.owner_id = owner.id
  end

  def add_dog(dog)
    self.dogs << dog
    self.dog_id = dog.id
  end

  def change_date(date)
    self[:date] = date
  end

  def change_time(time)
    self[:time] = time
  end

end