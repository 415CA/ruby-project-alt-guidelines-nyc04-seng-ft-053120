class CreateGroomers < ActiveRecord::Migration[5.2]
  def change
    create_table :groomers do |t|
      t.string :name
      t.integer :appointment_id
    end
  end
end
