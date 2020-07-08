# frozen_string_literal: true

require_relative '../config/environment'

interface = Interface.new
user_instance = interface.login_or_register
user_instance = interface.login_or_register until user_instance
interface.user = user_instance
interface.main_menu
