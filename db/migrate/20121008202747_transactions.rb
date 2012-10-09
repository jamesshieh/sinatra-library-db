class Transactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.references :book, :null => false
      t.references :user, :null => false
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
