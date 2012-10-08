require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'

set :database, 'sqlite3:///database.db'

get '/' do
  "Hello there"
end

get '/index' do
  erb :index
end

get '/users' do
  @users = User.all
  erb :userindex
end

get '/users/search' do
  erb :searchuser
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :showuser
end

get '/books' do
  @books = Book.all
  erb :bookindex
end

get '/books/:id' do
  @book = Book.find(params[:id])
  erb :showbook
end

get '/transactions/' do
  @transactions = Transaction.all
end

get '/subjects/' do
  @subjects = Subject.all
end

post '/users/search' do
  @user = User.where("first_name = ? AND last_name = ? AND email = ?", params[:firstname], params[:lastname], params[:email])
  erb :usersearchresults
end

