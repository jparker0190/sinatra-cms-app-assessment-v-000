class CreateProperty < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :rooms
    end
  end
end
