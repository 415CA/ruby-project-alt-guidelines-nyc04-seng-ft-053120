class AddDogToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :dogs_id, :integer
  end
end
