require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'
require 'time'

set :database, 'sqlite3:///database.db'

User.create([
  { :email => "test1@test.com", :first_name => "test1", :last_name => "test1" },
  { :email => "test2@test.com", :first_name => "test2", :last_name => "test2" },
  { :email => "test3@test.com", :first_name => "test3", :last_name => "test3" },
  { :email => "test4@test.com", :first_name => "test4", :last_name => "test4" },
  { :email => "test5@test.com", :first_name => "test5", :last_name => "test5" },
  { :email => "test6@test.com", :first_name => "test6", :last_name => "test6" }
])

Book.create([
  { :author_first_name => "test1", :author_last_name => "test1", :title => "test1" },
  { :author_first_name => "test2", :author_last_name => "test2", :title => "test2" },
  { :author_first_name => "test3", :author_last_name => "test3", :title => "test3" },
  { :author_first_name => "test4", :author_last_name => "test4", :title => "test4" },
  { :author_first_name => "test5", :author_last_name => "test5", :title => "test5" }
])

Subject.create([
  { :subject => "Java", :description => "Java test" },
  { :subject => "Ruby", :description => "Ruby test" },
  { :subject => "Python", :description => "Python test" },
  { :subject => "Clojure", :description => "Clojure test" },
  { :subject => "C", :description => "C test" }
])

Transaction.create([
  { :books_id => 1, :users_id => 1, :open_date => Time.now },
  { :books_id => 2, :users_id => 6, :open_date => Time.now }
])

Booktag.create([
  { :books_id => 1, :subjects_id => 1 },
  { :books_id => 1, :subjects_id => 2 },
  { :books_id => 1, :subjects_id => 3 },
  { :books_id => 2, :subjects_id => 5 }
])
