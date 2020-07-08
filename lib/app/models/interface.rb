# frozen_string_literal: true

class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  # Initial welcome message
  def welcome
    puts 'Welcome to Fullstack Dog Groomers'
    puts 'We are the next-generation of luxury dog ownership.'
  end

  def logo
    system "clear"
    puts '
██████╗  ██████╗  ██████╗      ██████╗ ██████╗  ██████╗  ██████╗ ███╗   ███╗██╗███╗   ██╗ ██████╗ 
██╔══██╗██╔═══██╗██╔════╝     ██╔════╝ ██╔══██╗██╔═══██╗██╔═══██╗████╗ ████║██║████╗  ██║██╔════╝ 
██║  ██║██║   ██║██║  ███╗    ██║  ███╗██████╔╝██║   ██║██║   ██║██╔████╔██║██║██╔██╗ ██║██║  ███╗
██║  ██║██║   ██║██║   ██║    ██║   ██║██╔══██╗██║   ██║██║   ██║██║╚██╔╝██║██║██║╚██╗██║██║   ██║
██████╔╝╚██████╔╝╚██████╔╝    ╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║ ╚═╝ ██║██║██║ ╚████║╚██████╔╝
╚═════╝  ╚═════╝  ╚═════╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
    '
  end

  # Asks for user to login or create new account
  def login_or_register
    system 'clear'
    logo
    prompt.select('') do |menu|
      menu.choice 'Login', -> { Owner.login }
      menu.choice 'Register', -> { self.create_user }
      menu.choice 'Exit', -> { goodbye }
    end
  end

  def create_user
    Owner.create_user
  end

  # Category Menus #

  # Main menu

  def main_menu
    system 'clear'
    puts '
███    ███  █████  ██ ███    ██               ███    ███ ███████ ███    ██ ██    ██ 
████  ████ ██   ██ ██ ████   ██     ▄ ██ ▄    ████  ████ ██      ████   ██ ██    ██ 
██ ████ ██ ███████ ██ ██ ██  ██      ████     ██ ████ ██ █████   ██ ██  ██ ██    ██ 
██  ██  ██ ██   ██ ██ ██  ██ ██     ▀ ██ ▀    ██  ██  ██ ██      ██  ██ ██ ██    ██ 
██      ██ ██   ██ ██ ██   ████               ██      ██ ███████ ██   ████  ██████  
    '
    prompt.select("Welcome to Fullstack Dog Groomers") do |menu|
      menu.choice 'My Dogs', -> { dog_menu }
      menu.choice 'My Appointments', -> { appointment_menu }
      menu.choice 'My Grooming Services', -> { services_menu }
      menu.choice 'Exit', -> { goodbye }
    end
  end

  # Dog menu

  def dog_menu
    system 'clear'
    puts '
██████   ██████   ██████  ███████ 
██   ██ ██    ██ ██       ██      
██   ██ ██    ██ ██   ███ ███████ 
██   ██ ██    ██ ██    ██      ██ 
██████   ██████   ██████  ███████ 
    '
    prompt.select('Please select from the options below') do |menu|
      menu.choice 'Upcoming Appointments', -> { view_dog_appointments }
      menu.choice 'Add A New Dog', -> { new_dog }
      menu.choice 'Remove A Dog', -> { remove_dog }
      menu.choice 'My Grooming Services', -> { services_menu }
      menu.choice 'Main Menu', -> { main_menu }
    end
  end

  def add_dog_menu
    system 'clear'
    puts '
 █████  ██████  ██████                ██████   ██████   ██████  ███████ 
██   ██ ██   ██ ██   ██     ▄ ██ ▄    ██   ██ ██    ██ ██       ██      
███████ ██   ██ ██   ██      ████     ██   ██ ██    ██ ██   ███ ███████ 
██   ██ ██   ██ ██   ██     ▀ ██ ▀    ██   ██ ██    ██ ██    ██      ██ 
██   ██ ██████  ██████                ██████   ██████   ██████  ███████
    '
    prompt.select("#{user.name}, add another dog or select an option from the menu below") do |menu|
      menu.choice 'Add A New Dog', -> { new_dog }
      menu.choice 'My Dogs', -> { dog_menu }
      menu.choice 'My Appointments', -> { appointment_menu }
      menu.choice 'Main Menu', -> { main_menu }
      menu.choice 'Exit', -> { goodbye }
    end
  end

  # Appointment menu

  def appointment_menu
    system 'clear'
    puts '
 █████  ██████  ██████   ██████  ██ ███    ██ ████████ ███    ███ ███████ ███    ██ ████████ ███████ 
██   ██ ██   ██ ██   ██ ██    ██ ██ ████   ██    ██    ████  ████ ██      ████   ██    ██    ██      
███████ ██████  ██████  ██    ██ ██ ██ ██  ██    ██    ██ ████ ██ █████   ██ ██  ██    ██    ███████ 
██   ██ ██      ██      ██    ██ ██ ██  ██ ██    ██    ██  ██  ██ ██      ██  ██ ██    ██         ██ 
██   ██ ██      ██       ██████  ██ ██   ████    ██    ██      ██ ███████ ██   ████    ██    ███████ 
    '
    prompt.select("#{user.name}, please select from the menu below") do |menu|
      menu.choice 'Create New Appointment', -> { new_appointment }
      menu.choice 'Upcoming Appointments', -> { view_owner_appointments }
      menu.choice 'Reschedule Appointment', -> { reschedule_appointment }
      menu.choice 'Cancel Appointment', -> { cancel_appointment }
      menu.choice 'Main Menu', -> { main_menu }
    end
  end

  # Services menu

  def services_menu
    system 'clear'
    puts '
███████ ███████ ██████  ██    ██ ██  ██████ ███████ ███████ 
██      ██      ██   ██ ██    ██ ██ ██      ██      ██      
███████ █████   ██████  ██    ██ ██ ██      █████   ███████ 
     ██ ██      ██   ██  ██  ██  ██ ██      ██           ██ 
███████ ███████ ██   ██   ████   ██  ██████ ███████ ███████ 
    '
    prompt.select("#{user.name}, enjoy one of our luxury dog grooming services") do |menu|
      menu.choice 'Add Services', -> { add_service }
      menu.choice 'Remove Services', -> { remove_service }
      menu.choice 'My Appoinments', -> { appointment_menu }
      menu.choice 'My Dogs', -> { dog_menu }
      menu.choice 'Main Menu', -> { main_menu }
    end
  end

  # Dog Menu Methods

  def select_dog
    user.select_dog
  end

  def view_dog_appointments
    system 'clear'
    dog = user.select_dog
    if user.find_dog_appointments(dog)
      user.view_dog_appointments(dog)
      sleep(7)
    else user.find_dog_appointments(dog).empty?
      puts 'There are no appointments currently available'
    end
    dog_menu
  end

  def view_owner_appointments
    if !user.find_owner_appointments
      system 'clear'
      puts 'No upcoming appointments available'
      sleep(4)
      appointment_menu
    else
      system 'clear'
      puts user.view_appointments
      sleep(7)
      appointment_menu
    end
    appointment_menu
  end

  def new_dog
    user.new_dog
    add_dog_menu
  end

  def remove_dog
    dog = user.select_dog
    user.remove_dog(dog)
    dog_menu
  end

  def print_upcoming_appointments
    user.appointments.each(&:print_appointment)
  end

  # Appointment Menu Methods

  def new_appointment
    dog = user.select_dog
    service = user.select_service
    groomer = user.select_groomer_from_service(service)
    user.new_appointment(dog, service, groomer)
    appointment_menu
  end

  # Returns Appointment object from Owner's array
  def select_appointment
    user.select_appointment
  end

  def reschedule_appointment
    appointment_object = select_appointment
    user.reschedule_appointment(appointment_object)
    appointment_menu
  end

  def cancel_appointment
    appointment_object = select_appointment
    user.cancel_appointment(appointment_object)
    appointment_menu
  end

  # Service Menu Methods

  def add_service
    appointment_object = user.select_appointment
    service = user.select_service
    appointment_object.services << service
    puts "#{service.name} service has been added to your appointment"
    sleep(7)
    dog_menu
  end

  def remove_service
    appointment_object = user.select_appointment
    service = user.select_service_from_appointment(appointment_object)
    prompt = TTY::Prompt.new.ask('Are you sure you want to remove this service?')

    if prompt
      puts 'The service has been removed from your appointment'
      appointment_object.services.delete(service)
      sleep(5)
      dog_menu

    else !prompt
      puts 'We will keep your appointment as scheduled'
      sleep(5)
      dog_menu
    end
  end

  # Exit program method

  def sign_out
    system 'clear'
    puts 'Thank you for choosing Fullstack Dog Groomers!'
  end
end
