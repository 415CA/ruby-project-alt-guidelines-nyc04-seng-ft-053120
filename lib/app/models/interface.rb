class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end


  # Initial welcome message
  def welcome
    puts 'Welcome to Fullstack Dog Groomers!'
    puts 'We are the next-generation of luxury dog ownership.'
  end

  # Asks for user to login or create new account
  def login_or_register
    system "clear"
    prompt.select("Log-in or Register") do |menu|
      menu.choice "Log In", -> { Owner.login }
      menu.choice "Register", -> { Owner.create_new_user }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  # Category Menus #

  # Main menu 
  def main_menu
    system "clear"
    puts "Hello, #{user.name}, welcome to Fullstuck Dog Groomers!"
    prompt.select("Please select from the options below") do |menu|
      menu.choice "My Dogs", -> { self.dog_menu }
      menu.choice "My Appointments", -> { self.appointment_menu }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  # Dog menu
  def dog_menu
    system "clear"
    puts "Hello, welcome to the app, #{user.name}"
    prompt.select("What would you like to do?") do |menu|
      menu.choice "My dogs", -> { self.select_dog }
      menu.choice "Add a new dog", -> { self.add_new_dog }
      menu.choice "Remove a dog", -> { self.remove_dog }
      menu.choice "Grooming Services", -> { self.services_menu }
      menu.choice "My Appoinments", -> { self.appointment_menu }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Appointment menu
  def appointment_menu
    system "clear"
    puts "#{user.name}, below are your appointment options"
    prompt.select("Please select from the menu below") do |menu|
      menu.choice "Create New Appointment", -> { self.new_appointment }
      menu.choice "Upcoming Appointments", -> { self.select_appointment }
      menu.choice "Reschedule Appointment", -> { self.reschedule_appointment }
      menu.choice "Cancel Appointment", -> { self.cancel_appointment }
      menu.choice "Grooming Services", -> { self.services_menu }
      menu.choice "My Dogs", -> { self.dog_menu }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Services menu
  def services_menu
    system "clear"
    puts "#{user.name}, enjoy our luxury dog grooming services"
    prompt.select("Please select from the menu below") do |menu|
      menu.choice "Create New Appointment", -> { self.new_appointment }
      menu.choice "Add Grooming Services", -> { self.add_or_remove_services }
      menu.choice "My Appoinments", -> { self.appointment_menu }
      menu.choice "My Dogs", -> { self.dog_menu }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Dog Menu Methods

  def select_dog
    user.select_dog
  end

  def add_new_dog
    user.new_dog
  end

  def remove_dog
    user.remove_dog
  end

  # Appointment Menu Methods

  def new_appointment
    user.new_appointment
    self.main_menu
  end
  
  def select_appointment
    user.select_appointment
  end

  def reschedule_appointment
    user.reschedule_appointment
    self.main_menu
  end

  def cancel_appointment
    user.cancel_appointment
    self.main_menu
  end

  # Service Menu Methods

  def add_or_remove_services
    user.select_service
  end

  # Exit program method
  def goodbye
    system "clear"
    puts "Thank you for choosing Fullstack Dog Groomers!"
  end
end