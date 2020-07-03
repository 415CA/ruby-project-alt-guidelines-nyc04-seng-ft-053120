class AddOwnerToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :owners_id, :integer
  end
end