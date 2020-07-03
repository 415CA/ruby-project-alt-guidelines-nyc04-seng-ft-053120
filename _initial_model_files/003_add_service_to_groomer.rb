class AddServicesToGroomers < ActiveRecord::Migration[5.1]
  def change
    add_column :groomers, :services_id, :integer
  end
end