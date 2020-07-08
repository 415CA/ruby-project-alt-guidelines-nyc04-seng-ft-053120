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
      menu.choice "Register", -> { self.create_user }
      menu.choice "Exit", -> { self.goodbye }
    end
  end

  # Category Menus #

  # Main menu

  def main_menu
    system "clear"
    puts "Welcome to K-9 Dog Grooming"
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
      prompt.select("#{user.name}, add more dogs or choose another option") do |menu|
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
    prompt.select("#{user.name}, please select from the menu below") do |menu|
      menu.choice "Create New Appointment", -> { self.new_appointment }
      menu.choice "Upcoming Appointments", -> { self.view_owner_appointments }
      menu.choice "Reschedule Appointment", -> { self.reschedule_appointment }
      menu.choice "Cancel Appointment", -> { self.cancel_appointment }
      menu.choice "Main Menu", -> { self.main_menu }
    end
  end

  # Services menu

  def services_menu
    system "clear"
    prompt.select("#{user.name}, enjoy our luxury dog grooming services") do |menu|
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
    system "clear"
    dog = user.select_dog
    if user.find_dog_appointments(dog)
      user.view_dog_appointments(dog)
      sleep(7)
    else user.find_dog_appointments(dog).empty?
      puts 'There are no appointments currently available'
    end
    self.dog_menu
  end

  def view_owner_appointments
    if !user.find_owner_appointments
      system "clear"
      puts "No upcoming appointments available"
      sleep(4)
      self.appointment_menu
    else
      system "clear"
      puts user.view_appointments
      sleep(7)
      self.appointment_menu
    end
    self.appointment_menu
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
    user.appointments.each { |appointment| appointment.print_appointment }
  end

  # Appointment Menu Methods

  def new_appointment
    dog = user.select_dog
    service = user.select_service
    groomer = user.select_groomer_from_service(service)
    user.new_appointment(dog, service, groomer)
    self.appointment_menu
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
    self.appointment_menu
  end

  # Service Menu Methods

  def add_service
    appointment_object = user.select_appointment
    service = user.select_service
    appointment_object.services << service
    puts "#{service.name} service has been added to your appointment"
    sleep(7)
    self.dog_menu
  end

  def remove_service
    appointment_object = user.select_appointment
    service = user.select_service_from_appointment(appointment_object)
    prompt = TTY::Prompt.new.ask('Are you sure you want to remove this service?')

    if prompt
      puts "The service has been removed from your appointment"
      appointment_object.services.delete(service)
      sleep(5)
      self.dog_menu

    else !prompt
      puts "We will keep your appointment as scheduled"
      sleep(5)
      self.dog_menu
    end
  end

  # Exit program method

  def sign_out
    system "clear"
    puts "Thank you for choosing K-9 Dog Grooming!"
  end
end