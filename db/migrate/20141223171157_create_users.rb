class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :phone
      t.boolean :has_passcard

      t.timestamps
    end
  end
end
