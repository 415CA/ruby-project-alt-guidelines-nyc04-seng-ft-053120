# frozen_string_literal: true

Groomer.destroy_all
Service.destroy_all
Owner.destroy_all
Dog.destroy_all
Appointment.destroy_all

groomers = ['Emma', 'Louis', 'Margot', 'Kate', 'Mike', 'Phil', 'Denise']

groomers.each do |groomer|
  Groomer.create(name: groomer)
end

# Services
fullstack_grooming = Service.create(name: 'VIP Fullstack Grooming Service', price: 150)
paw_massage = Service.create(name: 'Paw Massage', price: 50)
sanitary_cleanup = Service.create(name: 'Sanitary Cleanup', price: 20)
full_brush_out = Service.create(name: 'Full Brush Out', price: 20)
face_shape_up = Service.create(name: 'Face Shape-Up', price: 15)
feet_shape_up = Service.create(name: 'Feet Shape-Up', price: 10)
nail_trim = Service.create(name: 'Nail Trim', price: 15)
nail_grinding = Service.create(name: 'Nail Grinding', price: 25)
nail_polish = Service.create(name: 'Nail Polish', price: 10)
teeth_brushing = Service.create(name: 'Teeth Brushing', price: 5)
flea_shampoo = Service.create(name: 'Flea Shampoo Treatment', price: 12)
ear_cleaning = Service.create(name: 'Ear Cleaning', price: 5)
hair_removal = Service.create(name: 'Hair Removal', price: 10)
bandana = Service.create(name: 'Merch: Our Signature Bandana', price: 10)
t_shirt = Service.create(name: 'Merch: FSDG T-Shirt Bandana', price: 15)
hat = Service.create(name: 'Merch: FSDG Hat Bandana', price: 10)
dog_bowl = Service.create(name: 'Merch: FSDG Dog Bowl', price: 20)