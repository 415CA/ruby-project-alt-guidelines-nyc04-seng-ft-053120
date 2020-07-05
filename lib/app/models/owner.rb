# frozen_string_literal: true

# Owner Class Methods

class Owner < ActiveRecord::Base
  belongs_to :appointment
  has_many :appointments
  has_many :dogs
  has_many :groomers, through: :appointments
  has_many :services, through: :groomers

  def self.create_a_new_user_please
    prompt = TTY::Prompt.new
    username_of_the_user = prompt.ask("What do you want your username to be?")
    if Owner.find_by(username: username_of_the_user)
      puts "That username has been taken."
      puts "Please select another name."
    end
    Owner.create(username: username_of_the_user)
  end

  def self.logging_someone_in
    prompt = TTY::Prompt.new
    username_of_the_user = prompt.ask('Please enter your username to get started.')
    found_user = Owner.find_by(name: username_of_the_user)
    if found_user
      return found_user
    else
      puts "Sorry, that name can not be found"
    end
  end

  def new_dog(dog_name)
    self.dogs.create(name: dog_name)
  end

  def add_dog(dog)
    self.dogs << dog
    self.dog_id = dog.id
  end

  def find_dog
    Dog.all.select do |dog_instance|
      dog_instance.owner_id == id
    end
  end

  def find_appointment
    Appointment.all.select do |appointment_instance|
      appointment_instance.owner_id == id
    end
  end
end
