class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end


  # Initial welcome message
  def welcome
    puts 'Welcome to K-9 Dog Grooming'
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
    puts "Hello, #{user.name}, welcome to K-9 Dog Grooming"
    prompt.select("Please select from the options below") do |menu|
      menu.choice "Dogs", -> { self.dog_menu }
      menu.choice "Appointments", -> { self.appointment_menu }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  # Dog menu
  def dog_menu
    system "clear"
    puts "Hello, #{user.name}, welcome to K-9 Dog Grooming"
    prompt.select("What would you like to do?") do |menu|
      menu.choice "My dogs", -> { self.view_dog_appointments}
      menu.choice "Add a new dog", -> { self.new_dog }
      menu.choice "Remove a dog", -> { self.remove_dog }
      menu.choice "Grooming Services", -> { self.services_menu }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  def dog_instance_menu
    system 'clear'
      prompt.select("Please add another dog or choose another option") do |menu|
      menu.choice "Add new dog", -> { self.new_dog}
      menu.choice "Return to dog menu", -> { self.dog_menu}
      menu.choice "Appointment menu", -> { self.appointment_menu }
      menu.choice "Main Menu", -> { self.main_menu }
      menu.choice "Exit", -> { self.goodbye }
      end
  end

  # Appointment menu
  def appointment_menu
    system "clear"
    puts "#{user.name}, below are your appointment options"
    prompt.select("Please select from the menu below") do |menu|
      menu.choice "Create New Appointment", -> { self.new_appointment }
      menu.choice "View Upcoming Appointments", -> { self.print_upcoming_appointments }
      menu.choice "Reschedule Appointment", -> { self.reschedule_appointment }
      menu.choice "Cancel Appointment", -> { self.cancel_appointment }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Services menu
  def services_menu
    system "clear"
    puts "#{user.name}, enjoy our luxury dog grooming services"
    prompt.select("Please select from the menu below") do |menu|
      menu.choice "Add Service", -> { self.add_service }
      menu.choice "Remove Service", -> { self.remove_service }
      menu.choice "My Appoinments", -> { self.appointment_menu }
      menu.choice "My Dogs", -> { self.dog_menu }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Dog Menu Methods

  def select_dog
    user.select_dog
  end

  def view_dog_appointments
    dog_object = user.select_dog
    #print Dog appointments
    return dog_object.appointments
    self.dog_menu
  end

  def view_owner_appointments
    user.appointments
    #print Dog appointments
    puts dog_object.appointments
    self.dog_menu
  end

  def new_dog
    user.new_dog
    self.dog_instance_menu
  end

  def remove_dog
    dog = user.select_dog
    user.remove_dog(dog)
    self.dog_menu
  end

  def print_upcoming_appointments
    self.appointments.each { |appointment| appointment.print_appointment }
  end

  # Appointment Menu Methods

  def new_appointment
    user.new_appointment
  end

  # Returns Appointment object from Owner's array
  def select_appointment
    user.select_appointment
  end

  def reschedule_appointment
    appointment_object = self.select_appointment
    user.reschedule_appointment(appointment_object)
    self.appointment_menu
  end

  def cancel_appointment
    appointment_object = self.select_appointment
    user.cancel_appointment(appointment_object)
    self.main_menu
  end

  # Service Menu Methods

  def add_service
    appointment_object = user.select_appointment
    service = user.select_service
    appointment_object.services << service
    puts "The service has been added to your appointment"
    sleep(3)
  end

  def remove_service
    appointment_object = user.select_appointment
    service = user.select_service_from_appointment(appointment_object)
    prompt = TTY::Prompt.new.ask('Are you sure you want to remove this service?')
    if prompt
      puts "The service has been removed from your appointment"
      appointment_object.services.delete(service)
      sleep(3)
    else !prompt
      puts "We will keep your appointment as scheduled"
      sleep(3)
    end
  end

  # Exit program method

  def goodbye
    system "clear"
    puts "Thank you for choosing K-9 Dog Grooming!"
  end
end