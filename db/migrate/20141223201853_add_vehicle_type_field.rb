class AddVehicleTypeField < ActiveRecord::Migration
  def change
  	add_column :vehicles, :vehicle_type, :string
  end
end
