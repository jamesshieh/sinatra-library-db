require 'sinatra'
require 'sinatra/activerecord'
require './db/models'
require './lib/user_database'
require './lib/book_database'
require './lib/catalog_database'

set :database, 'sqlite3:///database.db'

get '/' do
  redirect to('/index')
end

get '/index' do
  erb :index
end

get '/users/list' do
  @users = User.all
  erb :"users/userindex"
end

get '/users/search' do
  erb :"users/searchuser"
end

get '/users/create' do
  erb :"users/createuser"
end

get '/users/delete' do
  erb :"users/deleteuser"
end

post '/users/delete' do
  begin
    @user = UserDatabase.find_user(params[:email])
    erb :"users/confirmdelete"
  rescue
    puts "Exception!"
    erb :"users/errorpage"
  end
end

post '/users/confirmdelete' do
  if params[:confirm] == "Yes"
    UserDatabase.delete_user(params[:id])
    puts "User Deleted!"
    redirect to('/index')
  else
    puts "Delete Aborted!"
    redirect back
  end
end

post '/users/create' do
  UserDatabase.create_user(params[:first_name], params[:last_name], params[:email])
  @user = UserDatabase.find_user(params[:email])
  erb :"users/showuser"
end

get '/users/edit' do
  erb :"users/edituser"
end

post '/users/edit' do
  @user = UserDatabase.find_user(params[:email])
  UserDatabase.edit_user(@user.id, params[:first_name], params[:last_name], params[:newemail])
  @user = User.find(@user.id)
  erb :"users/showuser"
end

post '/users/searchemail' do
  @user = UserDatabase.find_user(params[:email])
  erb :"users/showuser"
end

post '/users/searchname' do
  @user = UserDatabase.search_user(params[:first_name], params[:last_name])
  erb :"users/usersearchresults"
end

get '/books/list' do
  @book = BookDatabase.get_catalog
  erb :"books/bookindex"
end

get '/books/new' do
  erb :"books/newbook"
end

post '/books/new' do
  @book = BookDatabase.new_book(params[:ti], params[:fn], params[:ln], params[:descr])
  erb :"books/showbook"
end

get '/books/search' do
  erb :"books/searchbook"
end

post '/books/searchauthor' do
  @book = BookDatabase.search_book_author(params[:fn], params[:ln])
  erb :"books/bookindex"
end

post '/books/searchtitle' do
  @book = BookDatabase.search_book_title(params[:ti])
  erb :"books/bookindex"
end

get '/books/edit' do
  erb :"books/editbook"
end

get '/trans/list' do
  @transactions = Transaction.all
  erb :"transactions/transindex"
end

get '/trans/return' do
end

get '/trans/checkout' do
end

get '/trans/search' do
end

get '/subjects/list' do
  @subjects = Subject.all
  erb :subjectindex
end

get '/subjects/manage' do
end
