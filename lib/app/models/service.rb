# frozen_string_literal: true

# Service Class Methods

class Service < ActiveRecord::Base
  belongs_to :groomer

  has_many :appointments
  has_many :groomers
  has_many :owners, through: :appointments
  has_many :dogs, through: :owners

  def add_groomer(groomer)
    self.groomers << groomer
    self.groomer_id = groomer.id
  end
end
