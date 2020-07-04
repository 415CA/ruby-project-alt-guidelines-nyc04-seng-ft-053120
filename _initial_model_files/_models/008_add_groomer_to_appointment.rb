class AddGroomerToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :groomers_id, :integer
  end
end