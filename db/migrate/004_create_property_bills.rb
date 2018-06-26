class CreatePropertyBills < ActiveRecord::Migration
  def change
    create_table :property_bills do |t|
      t.integer :property_id
      t.integer :bill_id
    end
  end
end
