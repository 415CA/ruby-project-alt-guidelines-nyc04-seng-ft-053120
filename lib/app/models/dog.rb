# frozen_string_literal: true

# Dog Class Methods

class Dog < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :owner

  has_many :appointments
  has_many :owners
  has_many :groomers, through: :appointments
  has_many :services, through: :groomers

  def add_owner(owner)
    self.owners << owner
    self.owner_id = owner.id
  end

  def find_owners
    Owner.all.select do |owner_instance|
      owner_instance.dog_id == id
    end
  end

  def appointements
    Appointment.all.select do |appointment_instance|
      appointment_instance.dog_id == id
    end
  end

  def groomers
    Appointment.all.select do |appointment_instance|
      appointment_instance.dog_id == id
      groomers = appointment_instance.map(Groomers.find_by_id(appointment_instance.groomer_id))
      groomers
    end
  end
end
