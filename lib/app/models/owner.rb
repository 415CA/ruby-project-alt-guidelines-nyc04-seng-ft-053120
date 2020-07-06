# frozen_string_literal: true

# Owner Class Methods

class Owner < ActiveRecord::Base
  belongs_to :appointment
  has_many :appointments
  has_many :dogs
  has_many :groomers, through: :appointments
  has_many :services, through: :groomers

  # TTY Prompt Methods

  def self.login
    system 'clear'
    prompt = TTY::Prompt.new
    username = prompt.ask('Enter username')
    found_user = Owner.find_by(name: username)
    if found_user
      found_user
    else
      puts 'Sorry, that name can not be found'
      sleep(5)
      Interface.login_or_register
    end
  end

  def self.create_new_user
    system "clear"
    prompt = TTY::Prompt.new
    username = prompt.ask('Create a username')
    if Owner.find_by(name: username)
      puts 'Sorry, that username has been taken'
      self.create_user_return_to_menu
    else
      Owner.create(name: username)
    end
  end

  def self.create_user_return_to_menu
    system "clear"
    prompt.select("Please select an option") do |menu|
      menu.choice "Choose another username", -> { self.create_new_user }
      menu.choice "Log In", -> { self.login }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  def dog_instance_menu
    system 'clear'
      prompt.select("Please add another dog or choose another option") do |menu|
      menu.choice "Add new dog", -> { self.new_dog}
      menu.choice "Return to dog menu", -> { Interface.dog_menu}
      menu.choice "Appointment menu", -> { Interface.appointment_menu }
      menu.choice "Main Menu", -> { Interface.main_menu }
      menu.choice "Exit", -> { Interface.goodbye }
      end
  end

  def select_dog
    system "clear"
    dog_names = dogs.map do |dog|
      { dog.name => dog.id }
    end

    if !dog_names.empty?
      dog_id = TTY::Prompt.new.select('Select a dog', dog_names)
      found_dog = Dog.find(dog_id)
      found_dog
    else
      puts "You don't have any dogs available!"
      sleep(5)
      Interface.dog_menu
    end
  end

  def select_appointment
    system "clear"
    appointments = self.appointments.map do |appointment|
      { "#{Dog.find_by_id(appointment.dog_id).name}: #{Service.find_by_id(appointment.service_id).name} with #{Groomer.find_by_id(appointment.groomer_id).name} on #{appointment.date} at #{appointment.time}" => appointment.id }
    end

    if !appointments.empty?
      appointment_id = TTY::Prompt.new.select('Upcoming appointments:', appointments)
      found_appointment = Appointment.find(appointment_id)
      found_appointment
    else
      puts 'No upcoming appointments available.'
      sleep(5)
      Interface.appointment_menu
    end
  end

  def select_service
    system "clear"
    service_names = Service.all.map do |service|
      { service.name => service.id }
    end

    if !service_names.empty?
      service_id = TTY::Prompt.new.select('Select a service', service_names)
      found_service = service.find(service_id)
      found_service
    else
      puts "You don't have any services available!"
      sleep(5)
      Interface.service_menu
    end
  end

  # Appointment Methods

  def new_appointment
    # Create a team and associate it to the user
    dog = self.select_dog.id #TTY select instance from owner.dogs array
    service = self.select_service #TTY select service instance from service.all array
    groomer = service.groomer_id
    service_id = service.id
    date = TTY::Prompt
    time = TTY::Prompt
    self.Appointment.create( self.id, groomer, dog, service, date, time )
  end

  def add_or_remove_services
    # Add or remove services from an appointment
  end
  
  def reschedule_appointment
    # Create an appoinment and associate it to the user
  end

  def cancel_appointment
    # From the owners's array of appointments, choose an appointment to destroy
  end

  # Dog Methods

  # Creates a new dog and checks if there is an existing instance with that name
  def new_dog
    system "clear"
    prompt = TTY::Prompt.new
    dog_name = prompt.ask('Enter the name of your dog')
    
    if self.dogs == 0

      new_dog = dogs.create(name: dog_name)
      self.dogs << new_dog
      self.dog_id = new_dog.id
      Interface.dog_menu

    elsif self.dogs > 0 && !dog_exist?(dog_name)
      
      new_dog = dogs.create(name: dog_name)
      self.dogs << new_dog
      Interface.dog_menu

    else self.dogs > 0 && dog_exist?(dog_name)
      puts 'That dog is already in our system'
      self.dog_instance_menu
    end
  end

  # Returns true if dog is in owner.dogs array
  def dog_exist?(dog_name)
    self.dogs.find { |dog| dog.name == dog_name }
  end

end
