class AddDogToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :dog_id, :integer
  end
end
