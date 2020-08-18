class CreateFurnitures < ActiveRecord::Migration[6.0]
  def self.up
    create_table :furnitures do |t|
      t.integer :visible_id
      t.string :name
    end
  end
end