class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.integer :amount
      t.integer :property_id
  end
end
end
