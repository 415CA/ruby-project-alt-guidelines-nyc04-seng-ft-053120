class AddServiceToGroomer < ActiveRecord::Migration[6.0]
  def change
    add_column :groomers, :services_id, :integer
  end
end
