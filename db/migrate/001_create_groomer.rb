class CreateGroomer < ActiveRecord::Base[5.2]
  def change
    create_table :groomers do |t|
      t.string :name

      t.timestamps
    end
  end
end