# frozen_string_literal: true

# Appointment Class Methods

class Appointment < ActiveRecord::Base
  has_many :owners
  has_many :groomers
  has_many :dogs
  has_many :services

  # has_one :owners
  # has_one :groomers
  # has_one :dogs
  # has_many :services

  def add_groomer(groomer)
    self.groomers << groomer
    self.groomer_id = groomer.id
  end

  def add_service(service)
    self.services << service
    self.service_id = service.id
  end

  def add_owner(owner)
    self.owners << owner
    self.owner_id = owner.id
  end

  def add_dog(dog)
    self.dogs << dog
    self.dog_id = dog.id
  end

  def change_date(date)
    self[:date] = date
  end

  def change_time(time)
    self[:time] = time
  end

end