class AddDogsToOwners < ActiveRecord::ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :dog_id, :integer
  end
end