class Groomer < ActiveRecord::Base
  has_many :services
  has_many :appointments
end