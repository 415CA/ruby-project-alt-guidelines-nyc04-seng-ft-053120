class Appointment < ActiveRecord::Base
  has_many :owners
  belongs_to :groomers
  has_many :dogs, through: :owners
  has_many :services, through: :groomers
end