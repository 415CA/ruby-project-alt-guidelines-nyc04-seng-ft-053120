# frozen_string_literal: true

# Groomer Class Methods

class Groomer < ActiveRecord::Base
  belongs_to :appointment

  has_many :appointments
  has_many :services
  has_many :owners, through: :appointments
  has_many :dogs, through: :owners

  def add_to_services
    Service.all.each{|service|service.groomers << self}
  end

  def new_service(name, price)
    self.services.create(name: name, price: price)
  end

  def add_service(service)
    self.services << service
    self.service_id = service.id
  end



end
