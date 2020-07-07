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
    prompt = TTY::Prompt.new
    username = prompt.ask('Enter username')
    found_user = Owner.find_by(name: username)
    if found_user
      found_user
    else
      puts 'Sorry, that name can not be found'
      sleep(2)
    end
  end

  def self.create_new_user
    system "clear"
    prompt = TTY::Prompt.new
    username = prompt.ask('Create a username')
    if Owner.all.find_by(name: username)
      puts 'Sorry, that username has been taken'
      sleep(2)
#      prompt.select("Please select an option") do |menu|
#      menu.choice "Choose another username", -> { self.create_new_user }
#      menu.choice "Log In", -> { self.login }
#      menu.choice "Exit", -> { self.goodbye }
#      end
    end
    Owner.create(name: username)
    puts "Your username is #{username}"
    sleep(2)
  end

  def self.create_user_return_to_menu
    system "clear"
    prompt.select("Please select an option") do |menu|
      menu.choice "Choose another username", -> { self.create_new_user }
      menu.choice "Log In", -> { self.login }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  # Class Object Retrival Methods

  def select_dog
    system "clear"
    dog_names = dogs.map do |dog|
      { dog.name => dog.id }
    end

    if !dog_names.empty?
      dog_id = TTY::Prompt.new.select('Select a dog', dog_names)
      found_dog = Dog.find_by_id(dog_id)
      found_dog
    else
      puts "You do not have any dogs listed on your account."
      sleep(3)
    end
  end

  def select_appointment
    system "clear"

    appointments = self.appointments.map do |appointment|
      { "#{Dog.find_by_id(appointment.dog_id).name}: #{Service.find_by_id(appointment.service_id).name} with #{Groomer.find_by_id(appointment.groomer_id).name} on #{appointment.date} at #{appointment.time}" => appointment.id }
    end

    if !appointments.empty?
      appointment_id = TTY::Prompt.new.select('Upcoming appointments:', appointments)
      found_appointment = Appointment.find_by_id(appointment_id)
      found_appointment
    else
      puts 'No upcoming appointments available.'
      sleep(2)
    end
  end

  def select_service
    system "clear"
    service_names = Service.all.map do |service|
      { service.name => service.id }
    end

    if !service_names.empty?
      service_id = TTY::Prompt.new.select('Select a service', service_names)
      found_service = Service.all.find_by_id(service_id)
      found_service
    else
      puts "You do not have any services available!"
      sleep(3)
    end
  end

  def select_service_from_appointment(appointment_object)
    system "clear"
    service_names = appointment_object.services.map do |service|
      { service.name => service.id }
    end

    if !service_names.empty?
      service_id = TTY::Prompt.new.select('Select a service', service_names)
      found_service = appointment_object.services.find_by_id(service_id)
      found_service
    else
      puts "You do not have any services available!"
      sleep(3)
    end
  end

  def select_groomer_from_service(service_object)
    system "clear"
    groomer_names = service_object.groomers.map do |groomer|
      { groomer.name => groomer.id }
    end

    if !groomer_names.empty?
      groomer_id = TTY::Prompt.new.select('Select a groomer', groomer_names)
      found_groomer = service_object.groomers.find_by_id(groomer_id) # Return Groomer object from Service array
      found_groomer
    else
      puts "You do not have any groomers available!"
      sleep(3)
    end
  end

  # Appointment Creation Methods

  def new_appointment
    appointment_object = Appointment.new
    dog_object = self.select_dog
    service_object = self.select_service
    groomer_object = self.select_groomer_from_service(service_object)

    date = TTY::Prompt.new.ask('Enter your desired date. Ex: June 23')
    time = TTY::Prompt.new.ask('Enter your desired time. Ex: 10:00 AM')
    binding.pry
    appointment_object.add_groomer(appointment_object, groomer_object).add_dog(appointment_object, dog_object).add_service(appointment_object, service_object).change_date(appointment_object, date).change_time(appointment_object, time)

   # appointment_object.add_groomer(groomer_object)

    # appointment_object.add_to_attribute_array(appointment_object, self, groomer_object, dog_object, service_object, date, time)
    
    # ( self.id, groomer_object.id, dog_object.id, service_object.id, date, time)

  #  self.appointments << appointment_object
  #  appointment_object.dogs << dog_object
  #  appointment_object.groomers << groomer_object
  #  appointment_object.services << service_object
  #  appointment_object[:date] = date
  #  appointment_object[:time] = time
  end

  def add_to_attribute_array(appointment_object, owner_object, groomer_object, dog_object, service_object, date, time)
    appointment_object.owners << owner_object
    appointment_object.groomers << groomer_object
    appointment_object.dogs << dog_object
    appointment_object.services << service_object
    appointment_object[:date] = date
    appointment_object[:time] = time
  end


  def add_groomer(appointment_object, groomer)
    appointment_object.groomers << groomer
    appointment_object.groomer_id = groomer.id
  end

  def add_service(appointment_object, service)
    appointment_object.services << service
    appointment_object..service_id = service.id
  end

  def add_owner(appointment_object, owner)
    appointment_object.owners << owner
    appointment_object.owner_id = owner.id
  end

  def add_dog(appointment_object, dog)
    appointment_object.dogs << dog
    appointment_object.dog_id = dog.id
  end

  def change_date(date)
    appointment_object[:date] = date
  end

  def change_time(time)
    appointment_object[:time] = time
  end

  # Appointment Update Methods

  def reschedule_appointment(appointment_object)
    date = TTY::Prompt.new.ask('Enter your desired date. Ex: June 23')
    time = TTY::Prompt.new.ask('Enter your desired time. Ex: 10:00 AM')

    prompt = TTY::Prompt.new.yes?("Are you sure you want to reschedule your appointment for #{date} at #{time}?")

    if prompt
      puts "We have recieved your request."
      puts "You will recieve an email once your Groomer has confirmed the changes."
      sleep(3)

      appointment_object.date = date
      appointment_object.time = time

    else !prompt
      puts "We will keep your appointment as scheduled for #{appointment_object.date} at #{appointment_object.time}"
      sleep(3)
    end
  end

  # Appointment Destroy Methods

  def cancel_appointment(appointment_object)
    date = appointment_object.date
    time = appointment_object.time

    prompt = TTY::Prompt.new.yes?("Are you sure you want to cancel the appointment scheduled for #{date} at #{time}?")

    case appointment_object.dogs
    when appointment_object.dogs.count > 1

      dog_name = appointment_object.dogs.map{|dog| dog.name }.join(" and ")

      if prompt
        puts "Your appointment scheduled for #{date} at #{time} has been cancled"
        puts "If you would like to add #{dog_name} back at anytime,"
        puts "Please use Schedule New Appointment option in the My Appointments menu"
        sleep(3)
        self.appointments.delete(appointment_object)

      else !prompt
        puts "We will keep your appointment scheduled for #{date} at #{time} on your account."
        sleep(3)
      end

    when appointment_object.dogs.count == 1

      dog_name = appointment_object.dogs.map{|dog| dog.name }

      if prompt
        puts "Your appointment scheduled for #{date} at #{time} has been cancled"
        puts "If you would like to add #{dog_name} back at anytime,"
        puts "Please use Schedule New Appointment option in the My Appointments menu"
        sleep(3)
        self.appointments.delete(appointment_object)

      else !prompt
        puts "We will keep your appointment scheduled for #{date} at #{time} on your account."
        sleep(3)
      end

    else appointment_object.dogs.count.zero?
      puts "Your appointment has been cancled"
      self.appointments.delete(appointment_object)
      sleep(3)
    end
  end

  # # Dog Methods # #

  # Dog Creation Methods
  def new_dog
    system "clear"
    prompt = TTY::Prompt.new
    dog_name = prompt.ask('Enter the name of your dog')

    if dog_exist?(dog_name)
      puts 'That name already exists.'
      sleep(2)
      self.new_dog
    end

    new_dog = Dog.create(name: dog_name)
    self.dogs << new_dog
    puts "#{dog_name} has been added to your account."
    sleep(2)
  end

  # Dog Destroy Methods

  def remove_dog(dog_object)
    dog_name = dog_object.name
    prompt = TTY::Prompt.new.yes?("Are you sure you want to remove #{dog_name} from your account?")
    
    if prompt
      puts "#{dog_name} has been removed from your account"
      puts "If you would like to add #{dog_name} back at anytime,"
      puts "Please use Add A New Dog in the My Dogs menu"
      sleep(3)
      Dog.all.delete(dog_object)
    else !prompt
      puts "We will keep your #{dog_name} on your account."
      sleep(3)
    end
  end
  

  # Dog Validation Methods

  def dog_exist?(dog_name)
    self.dogs.any?{ |dog| dog[:name] == dog_name }
  end
end
