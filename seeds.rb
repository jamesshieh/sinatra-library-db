require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'
require 'time'

set :database, 'sqlite3:///database.db'

User.create([
  { :email => "james.c.shieh@gmail.com", :first_name => "James", :last_name => "Shieh" },
  { :email => "pikachu@gmail.com", :first_name => "Pikachu", :last_name => "Lightning" },
  { :email => "squirtle@gmail.com", :first_name => "Squirtle", :last_name => "Water" },
  { :email => "charmander@gmail.com", :first_name => "Charmander", :last_name => "Fire" },
  { :email => "bulbasaur@gmail.com", :first_name => "Bulbasaur", :last_name => "Grass" },
])

Book.create([
  { :author_first_name => "Ruby", :author_last_name => "Book", :title => "Ruby Book" },
  { :author_first_name => "Testjava", :author_last_name => "Testbook", :title => "Java Book" },
  { :author_first_name => "Ruby", :author_last_name => "Book", :title => "Ruby Book" },
  { :author_first_name => "Testnode", :author_last_name => "Testbook", :title => "Node Book" },
  { :author_first_name => "Julia", :author_last_name => "Test", :title => "Julea Book" }
])

Subject.create([
  { :subject => "Java", :description => "Java test" },
  { :subject => "Ruby", :description => "Ruby test" },
  { :subject => "Python", :description => "Python test" },
  { :subject => "Clojure", :description => "Clojure test" },
  { :subject => "C", :description => "C test" }
])

Transaction.create([
  { :book_id => 1, :user_id => 1, :open_date => Time.now , :closed_date => Time.now, :active_flag => false},
  { :book_id => 1, :user_id => 3, :open_date => Time.now },
  { :book_id => 2, :user_id => 2, :open_date => Time.now }
])

Booktag.create([
  { :books_id => 1, :subjects_id => 1 },
  { :books_id => 1, :subjects_id => 2 },
  { :books_id => 1, :subjects_id => 3 },
  { :books_id => 2, :subjects_id => 5 }
])
