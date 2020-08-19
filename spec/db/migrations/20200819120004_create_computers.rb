class CreateComputers < ActiveRecord::Migration[6.0]
  def self.up
    create_table :computers do |t|
      t.string :serial_number
      t.string :name
    end
  end
end
