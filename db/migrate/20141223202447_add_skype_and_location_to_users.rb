class AddSkypeAndLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skype, :string
    add_column :users, :office, :number
    add_column :users, :room, :string
  end
end
