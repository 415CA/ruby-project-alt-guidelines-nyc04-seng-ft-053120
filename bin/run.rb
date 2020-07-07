require_relative '../config/environment'

interface = Interface.new()
interface.welcome

user_instance = interface.login_or_register

until user_instance
  user_instance = interface.login_or_register
end

interface.user = user_instance

interface.main_menu
