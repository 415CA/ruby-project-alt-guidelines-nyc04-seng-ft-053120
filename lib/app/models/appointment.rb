# frozen_string_literal: true

# Appointment Class Methods

class Appointment < ActiveRecord::Base
  attr_accessor :prompt, :user

  has_many :owners
  has_many :groomers
  has_many :dogs
  has_many :services

  def print_owners
    self.owners.map { |owner_instance| "Owner: #{owner_instance.name}" }.join(" | ")
  end

  def print_dogs
    self.dogs.map { |dog_instance| "Dog: #{dog_instance.name}" }.join(" | ")
  end

  def print_groomers
    self.groomers.map { |groomer_instance| "Groomer: #{groomer_instance.name}"}.join(" | ")
  end

  def print_services
    self.services.map { |service_instance| "#{service_instance[:name]}: $#{service_instance[:price]}"}.join(" | ")
  end

  def total_service_price
    self.services.reduce(0){ |sum, service_instance| sum + service_instance[:price] }
  end

  def print_appointment
    puts "#{print_owners}"
    puts "#{print_dogs}"
    puts "#{print_groomers}"
    puts "#{print_services}"
    puts "The total for your appointment is $#{total_service_price}."
    self.id
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