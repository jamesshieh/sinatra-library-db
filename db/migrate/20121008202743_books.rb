class Books < ActiveRecord::Migration
  def up
    create_table :books do |t|
      t.string :title, :null => false
      t.string :author_first_name
      t.string :author_last_name
      t.text :description
      t.boolean :checked_out_flag, :default => false

      t.timestamp
      end
  end

  def down
    drop table books
  end
end
