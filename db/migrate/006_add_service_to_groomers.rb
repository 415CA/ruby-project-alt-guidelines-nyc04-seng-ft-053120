class AddServiceToGroomers < ActiveRecord::Migration[6.0]
  def change
    add_column :groomers, :service_id, :integer
  end
end
