require 'sinatra'
require 'sinatra/activerecord'
require './db/models'
require './lib/user_database'

set :database, 'sqlite3:///database.db'

get '/' do
  redirect to('/index')
end

get '/index' do
  erb :index
end

get '/users/list' do
  @users = User.all
  erb :userindex
end

get '/users/search' do
  erb :searchuser
end

get '/users/create' do
  erb :createuser
end

get '/users/delete' do
  erb :deleteuser
end

post '/users/delete' do
  begin
    @user = UserDatabase.find_user(params[:email])
    erb :confirmdelete
  rescue
    puts "Exception!"
    erb :errorpage
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
  erb :showuser
end

get '/users/edit' do
  erb :edituser
end

post '/users/edit' do
  @user = UserDatabase.find_user(params[:email])
  UserDatabase.Edit_user(@user.id, params[:first_name], params[:last_name], params[:newemail])
  @user = User.find(@user.id)
  erb :showuser
end

post '/users/searchemail' do
  @user = UserDatabase.find_user(params[:email])
  erb :usersearchresults
end

post '/users/searchname' do
  @user = UserDatabase.search_user(params[:first_name], params[:last_name])
  erb :usersearchresults
end

get '/books/list' do
  @books = Book.all
  erb :bookindex
end

get '/books/new' do
end

get '/books/search' do
end

get '/books/edit' do
end

get '/trans/list' do
  @transactions = Transaction.all
  erb :transindex
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
