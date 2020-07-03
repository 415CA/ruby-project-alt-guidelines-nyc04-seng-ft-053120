class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.integer :groomers_id
      t.integer :services_id
      t.integer :owners_id
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end