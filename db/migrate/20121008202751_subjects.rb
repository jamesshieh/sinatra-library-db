class Subjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
      t.string :subject
      t.text :description
    end
  end

  def down
    drop table subjects
  end
end
