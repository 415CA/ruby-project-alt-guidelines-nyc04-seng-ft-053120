# frozen_string_literal: true

# Owner Class Methods

class Owner < ActiveRecord::Base
  attr_accessor :prompt, :user

  belongs_to :appointment
  has_many :appointments
  has_many :dogs
  has_many :groomers, through: :appointments
  has_many :services, through: :groomers

  # TTY Prompt Methods

  def self.login
    system 'clear'
    username = TTY::Prompt.new.ask('Enter Username')
    found_user = Owner.find_by(name: username)

    if !found_user
      puts 'Sorry, that name can not be found'
      TTY::Prompt.new.select('Please select an option') do |menu|
        menu.choice 'Register', -> { create_user }
        menu.choice 'Login', -> { login }
        menu.choice 'Exit', -> { goodbye }
      end

    elsif found_user
      found_user
    end
  end

  def self.create_user
    system 'clear'
    username = TTY::Prompt.new.ask('Create A Username')
    found_user = Owner.find_by(name: username)

    if found_user
      puts 'Sorry, that username has been taken'
      TTY::Prompt.new.select('Please select an option') do |menu|
        menu.choice 'Choose another username', -> { create_user }
        menu.choice 'Login', -> { login }
        menu.choice 'Exit', -> { goodbye }
      end
    else
      system 'clear'
      owner = Owner.create(name: username)
      puts "Welcome to Fullstack Dog Groomers #{username}!"
      owner
      sleep(2)
    end
  end

  def self.create_user_return_to_menu
    system 'clear'
    prompt.select('Please select an option') do |menu|
      menu.choice 'Choose another username', -> { create_new_user }
      menu.choice 'Log In', -> { login }
      menu.choice 'Exit', -> { goodbye }
    end
  end

  # Class Object Retrival Methods

  def select_dog
    system 'clear'
    dog_names = dogs.map do |dog|
      { dog.name => dog.id }
    end

    if !dog_names.empty?
      dog_id = TTY::Prompt.new.select('Select a dog', dog_names)
      found_dog = Dog.find_by_id(dog_id)
      found_dog
    else
      puts 'You do not have any dogs listed on your account.'
      sleep(4)
    end
  end

  def select_appointment
    system 'clear'

    owner_appointments = Appointment.all.select { |appointment| appointment.owners.include?(self) }

    appointments = owner_appointments.map do |appointment|
      groomer = appointment.groomers.map { |service| service.name.to_s }.join(' and ')
      dogs = appointment.dogs.map { |dog_instance| dog_instance.name.to_s }.join(' and ')
      service = appointment.services.map { |service| service.name.to_s }.join(' and ')

      { "#{dogs}: #{service} with #{groomer} on #{appointment.date} at #{appointment.time}" => appointment.id }
    end

    if !appointments.empty?
      appointment_id = TTY::Prompt.new.select('Upcoming appointments:', appointments)
      found_appointment = Appointment.find_by_id(appointment_id)
      found_appointment
    else
      puts 'No upcoming appointments available.'
      sleep(4)
    end
  end

  def select_service
    system 'clear'
    service_names = Service.all.map do |service|
      { service.name => service.id }
    end

    if !service_names.empty?
      service_id = TTY::Prompt.new.select('Select a service', service_names)
      found_service = Service.all.find_by_id(service_id)
      found_service
    else
      puts 'You do not have any services available!'
      sleep(4)
    end
  end

  def select_service_from_appointment(appointment_object)
    system 'clear'
    service_names = appointment_object.services.map do |service|
      { service.name => service.id }
    end

    if !service_names.empty?
      service_id = TTY::Prompt.new.select('Select a service', service_names)
      found_service = appointment_object.services.find_by_id(service_id)
      found_service
    else
      puts 'You do not have any services available!'
      sleep(4)
    end
  end

  def select_groomer
    system 'clear'
    groomer_names = Groomer.all.map do |groomer|
      { groomer.name => groomer.id }
    end

    if !groomer_names.empty?
      groomer_id = TTY::Prompt.new.select('Select a groomer', groomer_names)
      found_groomer = Groomer.all.find_by_id(groomer_id)
      found_groomer
    else
      puts 'You do not have any groomers available!'
      sleep(3)
    end
  end

  # Appointment Creation Methods

  def new_appointment(dog, service, groomer)
    date = TTY::Prompt.new.ask('Enter your desired date. (Ex: June 23)')
    time = TTY::Prompt.new.ask('Enter your desired time. (Ex: 10:00 AM)')

    appointment = Appointment.create(owner_id: id, groomer_id: groomer.id, dog_id: dog.id, service_id: service.id, date: date, time: time)

    appointment.owners << self
    appointment.groomers << groomer
    appointment.dogs << dog
    appointment.services << service

    puts "Your appointment is scheduled for #{date} at #{time} with #{groomer.name}"
    sleep(4)
    appointment
  end

  # Appointment retrival and view methods

  def find_owner_appointments
    Appointment.all.select { |appointment| appointment.owners.include?(self) || appointment.id == id }
  end

  def view_appointments
    find_owner_appointments.map(&:print_appointment)
  end

  def find_dog_appointments(dog)
    Appointment.all.select { |appointment| appointment.dogs.include?(dog) || appointment.dog_id == dog.id }
  end

  def view_dog_appointments(dog)
    find_dog_appointments(dog).map(&:print_appointment)
  end

  # Appointment Update Methods

  def reschedule_appointment(appointment_object)
    date = TTY::Prompt.new.ask('Enter your desired date. Ex: June 23')
    time = TTY::Prompt.new.ask('Enter your desired time. Ex: 10:00 AM')

    prompt = TTY::Prompt.new.yes?("Are you sure you want to reschedule your appointment for #{date} at #{time}?")

    if prompt
      puts 'We have received your request.'
      puts 'An e-mail from your Groomer will be sent once they confirm the changes.'
      sleep(5)

      appointment_object.date = date
      appointment_object.time = time

    else !prompt
        puts "We will keep your appointment as scheduled for #{appointment_object.date} at #{appointment_object.time}"
        sleep(5)
    end
  end

  # Appointment Destroy Methods

  def cancel_appointment(appointment_object)
    date = appointment_object.date
    time = appointment_object.time
    dog_appointments = appointment_object.dogs

    prompt = TTY::Prompt.new.yes?("Are you sure you want to cancel the appointment scheduled for #{date} at #{time}?")

    case appointment_object.dogs
    when appointment_object.dogs.count > 1

      dog_name = appointment_object.dogs.map(&:name).join(' and ')

      if prompt
        puts "Your appointment scheduled for #{date} at #{time} has been canceled"
        puts 'If you would like to add re-book at a later date'
        puts 'Please use the Schedule New Appointment option in the My Appointments menu'
        destroy_appointment(appointment_object)
        sleep(5)

      else !prompt
        puts "We will keep your appointment scheduled for #{date} at #{time}."
        sleep(5)
      end

    else appointment_object.dogs.count == 1

        dog_name = appointment_object.dogs.map(&:name)

        if prompt

          puts "Your appointment scheduled for #{date} at #{time} has been canceled."
          puts 'If you would like to add re-book at a later date'
          puts 'Please use the Schedule New Appointment option in the My Appointments menu'
          destroy_appointment(appointment_object)
          sleep(5)

        else !prompt
          puts "We will keep your appointment scheduled for #{date} at #{time} on your account."
          sleep(5)
        end
    end
  end

  # # Dog Methods # #

  # Dog Creation Methods
  def new_dog
    system 'clear'
    dog_name = TTY::Prompt.new.ask('Enter the name of your dog')

    if dog_exist?(dog_name)
      puts 'That name already exists.'
      sleep(4)
      new_dog
    end

    new_dog = Dog.create(name: dog_name)
    dogs << new_dog
    puts "#{dog_name} has been added to your account."
    sleep(4)
  end

  # Dog Destroy Methods

  def remove_dog(dog_object)
    dog_name = dog_object.name
    prompt = TTY::Prompt.new.yes?("Are you sure you want to remove #{dog_name} from your account?")

    if prompt

      puts "#{dog_name} has been removed from your account"
      puts "If you would like to add #{dog_name} back at anytime,"
      puts 'Use Add A New Dog in the My Dogs menu'
      destroy_dog(dog_object)
      sleep(4)

    else !prompt
      puts "We will keep your #{dog_name} on your account."
      sleep(4)
    end
  end

  def destroy_appointment(appointment_object)
    appointments.delete(appointment_object) if appointments.find { |a| a == appointment_object }
    Appointment.all.delete(appointment_object) if Appointment.all.find { |a| a == appointment_object }
    if Groomer.all.find { |a| a == appointment_object }
      Groomer.all.each { |g| g.appointments.delete(appointment_object) }
    end
    if Service.all.find { |a| a == appointment_object }
      Service.all.each { |s| s.appointments.delete(appointment_object) }
    end
    Dog.all.each { |_d| s.appointments.delete(appointment_object) } if Dog.all.find { |a| a == appointment_object }
  end

  def destroy_dog(dog_object)
    dogs.delete(dog_object) if dogs.find { |d| d == dog_object }
    Appointment.all.each { |d| d.dogs.delete(dog_object) } if Appointment.all.find { |d| d == dog_object }
    Dog.all.delete(dog_object) if Dog.all.find { |a| a == dog_object }
  end

  # Dog Validation Methods

  def dog_exist?(dog_name)
    dogs.any? { |dog| dog[:name] == dog_name }
  end

  def sign_out
    system 'clear'
    puts 'Thank you for choosing Fullstack Dog Groomers!'
  end
end
