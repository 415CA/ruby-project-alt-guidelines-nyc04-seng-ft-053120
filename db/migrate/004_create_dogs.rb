class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :owner_id
      t.integer :appointment_id

    end
  end
end
