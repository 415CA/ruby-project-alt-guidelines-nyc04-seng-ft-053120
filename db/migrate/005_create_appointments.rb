class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :owner_id
      t.integer :groomer_id
      t.integer :dog_id
      t.integer :service_id
      t.string :date
      t.string :time
    end
  end
end
