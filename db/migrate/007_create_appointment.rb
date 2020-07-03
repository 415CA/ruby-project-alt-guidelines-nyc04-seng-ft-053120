class CreateAppointments < ActiveRecord::Base[5.2]
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