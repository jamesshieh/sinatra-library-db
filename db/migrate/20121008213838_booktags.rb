class Booktags < ActiveRecord::Migration
  def up
    create_table :booktags do |t|
      t.references :books,    :null => false
      t.references :subjects, :null => false
    end
  end

  def down
    drop table booktags
  end
end
