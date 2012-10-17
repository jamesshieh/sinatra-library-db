class HackerschoolUsers < ActiveRecord::Migration
  def up
    remove_column :users, :username, :password, :salt
    add_column :users, :hs_id, :string
  end

  def down
    add_column :users, :salt, :string
    add_column :users, :username, :string
    add_column :users, :password, :string
    remove_column :users, :hs_id
  end
end
