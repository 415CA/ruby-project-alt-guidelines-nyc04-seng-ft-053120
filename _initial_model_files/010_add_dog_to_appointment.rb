class AddDogsToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :dogs_id, :integer
  end
end