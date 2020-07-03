class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :service_type
      t.integer :service_price

      t.timestamps
    end
  end
end
