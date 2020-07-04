class AddOwnerToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :owners_id, :integer
  end
end
