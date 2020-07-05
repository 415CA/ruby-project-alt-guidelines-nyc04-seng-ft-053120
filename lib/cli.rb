class CommandLineInterface

  def run
    cli = CommandLineInterface.new
    cli.introduction
    owner_name = gets.chomp
    cli.find_owner(owner_name) ? cli.welcome_back(owner_name) && owner = cli.find_owner(owner_name) : cli.greet && owner = Owner.create(name: owner_name)
    cli.main_menu(owner_name, owner)
  end
  
  # Displays welcome message
  def greet
    puts 'Welcome to K-9 Dog Grooming'
  end

  def welcome_back(owner_name)
    puts "Welcome back #{owner_name}"
  end

  def introduction
    puts 'K-9 Dog Grooming is the next-generation of luxury dog ownership.'
    puts "We've united the extravagance of a modern health spa experience"
    puts 'Please enter your username to get started.'
  end

  #menu page for user
  def main_menu(owner_name, owner)
    puts "#{page_break}\n
    Select from the following menu options to get started:\n
    1 - Make New Appointent
    2 - Reschedule Appointment
    3 - Cancel Appointment
    4 - Search for a Groomer
    5 - Exit
    "
  end

  # Menu options 
  def menu_options
    selection = gets.chomp
    case selection
    when '1'
      new_appointment
    when '2'
      reschedule_appointment
    when '3'
      cancel_appointment
    when '4'
      search_groomers
    when '5'
      exit
    else
    main_menu(owner_name, owner)
    menu_options
    end
  end
  
  def exit
    puts "Thank you for visiting K-9 Dog Grooming.\n We look foward to seeing you and your furry friend again soon."
    nil
  end


  # Creates new appointment
  def new_appointment
    Appointent.new()
  end
  
  def reschedule_appointment
    
  end
  
  def cancel_appointment
    
  end
  
  def search_groomers

  end

  def owner_name
    owner_name = gets.chomp
  end

  def dog_name
    dog_name = gets.chomp
  end

  def find_owner(owner_name)
    Owner.find_by(name: owner_name)
  end

  def find_dog(dog_name)
    Dog.find_by(name: dog_name)
  end

  #Page break line
  def page_break
    return "------------------------------------------------------------------------------------------------------"
  end

end