class AddPropertyIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :property_id, :integer
  end
end
