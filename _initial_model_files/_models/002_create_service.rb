class CreateService < ActiveRecord::ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :service_type
      t.integer :service_price

      t.timestamps
    end
  end
end