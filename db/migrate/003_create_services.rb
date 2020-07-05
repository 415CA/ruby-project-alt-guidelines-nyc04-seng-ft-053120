class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :price
      t.integer :groomer_id
      t.integer :appointment_id

    end
  end
end
