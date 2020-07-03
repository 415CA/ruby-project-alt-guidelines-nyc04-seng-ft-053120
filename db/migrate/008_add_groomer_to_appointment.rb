class AddGroomerToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :groomers_id, :integer
  end
end