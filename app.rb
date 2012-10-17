require 'sinatra'
require 'sinatra/activerecord'
require './db/models'
require './lib/user_database'
require './lib/book_database'
require './lib/transaction_database'
require 'debugger'

set :database, 'sqlite3:///database.db'

enable :sessions

get '/' do
  redirect to('/index')
end

get '/index' do
  if login?
    erb :"index"
  else
    redirect to('/login')
  end
end

get '/login' do
  if login?
    redirect to('/index')
  else
    erb :"login"
  end
end

post '/login' do
  if UserDatabase.authenticate(params[:un], params[:pw])
    debugger
    session[:username] = params[:un]
    redirect to('/index')
  else
    erb :"failedlogin"
  end
end

get '/logout' do
  session[:username] = nil
  redirect '/'
end

get '/users/list' do
  authorized?
  @users = User.all
  erb :"users/userindex"
end

get '/users/search' do
  authorized?
  erb :"users/searchuser"
end

get '/users/create' do
  authorized?
  erb :"users/createuser"
end

get '/users/delete' do
  authorized?
  erb :"users/deleteuser"
end

post '/users/delete' do
  authorized?
  begin
    @user = UserDatabase.find_user(username)
    erb :"users/confirmdelete"
  rescue
    puts "Exception!"
    erb :"users/errorpage"
  end
end

post '/users/confirmdelete' do
  authorized?
  if params[:confirm] == "Yes"
    UserDatabase.delete_user(username)
    puts "User Deleted!"
    redirect to('/index')
  else
    puts "Delete Aborted!"
    redirect back
  end
end

post '/users/create' do
  UserDatabase.create_user(params[:first_name], params[:last_name], params[:email], params[:un], params[:pw])
  @user = UserDatabase.find_user(params[:email])
  erb :"users/showuser"
end

get '/users/edit' do
  authorized?
  erb :"users/edituser"
end

post '/users/edit' do
  authorized?
  begin
    @user = UserDatabase.find_user(username)
    UserDatabase.edit_user(@user.id, params[:first_name], params[:last_name], params[:newemail])
    @user = User.find(@user.id)
    erb :"users/showuser"
  rescue
    erb :"users/searcherror"
  end
end

post '/users/searchusername' do
  begin
    @user = UserDatabase.find_user(params[:un])
    erb :"users/showuser"
  rescue
    erb :"users/searcherror"
  end
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
  authorized?
  erb :"books/newbook"
end

post '/books/new' do
  authorized?
  @book = BookDatabase.new_book(params[:ti], params[:fn], params[:ln], params[:descr], params[:owner])
  erb :"books/showbook"
end

get '/books/search' do
  authorized?
  erb :"books/searchbook"
end

post '/books/searchauthor' do
  begin
    @book = BookDatabase.search_book_author(params[:fn], params[:ln])
    erb :"books/bookindex"
  rescute
    erb :"books/searcherror"
  end
end

post '/books/searchtitle' do
  begin
    @book = BookDatabase.search_book_title(params[:ti])
    erb :"books/bookindex"
  rescue
    erb :"books/searcherror"
  end
end

get '/trans/list' do
  @transactions = TransactionDatabase.get_all_transactions
  erb :"transactions/transindex"
end

get '/trans/listactive' do
  @transactions = TransactionDatabase.get_active_transactions
  erb :"transactions/transindex"
end

get '/trans/return' do
  authorized?
  erb :"transactions/return"
end

post '/trans/return' do
  begin
    @transaction = TransactionDatabase.return_book(params[:ti], session[:username])
    erb :"transactions/showtrans"
  rescue
    puts "Exception!"
    erb :"/transactions/sorrypage"
  end
end

get '/trans/checkout' do
  authorized?
  erb :"transactions/checkout"
end

post '/trans/checkout' do
  begin
    puts session[:username]
    @transaction = TransactionDatabase.checkout_book(params[:ti], session[:username])
    erb :"transactions/showtrans"
  rescue
    puts "Exception!"
    erb :"/transactions/sorrypage"
  end
end

post '/trans/searchuser' do
  @transactions = TransactionDatabase.search_user(params[:un])
  erb :"/transactions/transindex"
end

post '/trans/searchbook' do
  @transactions = TransactionDatabase.search_book(params[:ti])
  erb :"/transactions/transindex"
end

get '/trans/search' do
  erb :"transactions/search"
end

get '/subjects/list' do
  @subjects = Subject.all
  erb :subjectindex
end

get '/subjects/manage' do
end

helpers do

  # Check if logged in
  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end

  # Return current username
  def username
    return session[:username]
  end

  def unauthorized!
    throw :halt, [401, 'Authorization required']
  end

  def authorized?
    unauthorized! unless login?
  end

  def admin?
    authorized?
    unauthorized! unless UserDatabase.is_admin?
  end

end
