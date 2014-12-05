class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :title
      t.string :registration_number
      t.integer :color

      t.timestamps
    end
    add_index :vehicles, :registration_number, unique: true
  end
end
