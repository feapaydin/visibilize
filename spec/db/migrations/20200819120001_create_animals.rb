class CreateAnimals < ActiveRecord::Migration[6.0]
  def self.up
    create_table :animals do |t|
      t.string :visible_id
      t.string :name
    end
  end
end
