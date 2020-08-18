class CreateBooks < ActiveRecord::Migration[6.0]
  def self.up
    create_table :books do |t|
      t.integer :page_number
      t.string :name
    end
  end
end