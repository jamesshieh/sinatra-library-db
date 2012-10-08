class Transactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.references :books, :null => false
      t.references :users, :null => false
      t.boolean :active_flag, :default => true
      t.timestamp :open_date
      t.timestamp :closed_date

      t.timestamps
    end
  end

  def down
    drop table transactions
  end
end
