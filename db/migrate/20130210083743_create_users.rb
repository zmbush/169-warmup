class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user, :null => false
      t.string :password, :null => false
      t.integer :count, :default => 0

      t.timestamps
    end

    add_index :users, :user, :unique => true
  end
end
