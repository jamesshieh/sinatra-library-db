require 'sinatra'
require 'sinatra/activerecord'
require './db/models'
require './lib/user_database'
require './lib/book_database'
require './lib/transaction_database'

set :database, 'sqlite3:///database.db'

enable :sessions

get '/' do
  redirect to('/index')
end

get '/index' do
  if login?
    erb :"index"
  else
    redirect('/login')
  end
end

get '/login' do
  if login?
    redirect('/index')
  else
    erb :"login"
  end
end

post '/login' do
  if UserDatabase.authenticate(params[:un], params[:pw])
    session[:username] = params[:un]
    redirect('/index')
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
  admin?
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
  UserDatabase.create_user(params[:first_name], params[:last_name], params[:email], params[:un], params[:pw])
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
  @book = BookDatabase.new_book(params[:ti], params[:fn], params[:ln], params[:descr], params[:owner])
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
  @transactions = TransactionDatabase.get_all_transactions
  erb :"transactions/transindex"
end

get '/trans/listactive' do
  @transactions = TransactionDatabase.get_active_transactions
  erb :"transactions/transindex"
end

get '/trans/return' do
  erb :"transactions/return"
end

post '/trans/return' do
  @transaction = TransactionDatabase.return_book(params[:ti], params[:em])
  erb :"transactions/showtrans"
end

get '/trans/checkout' do
  erb :"transactions/checkout"
end

post '/trans/checkout' do
  begin
    @transaction = TransactionDatabase.checkout_book(params[:ti], params[:em])
    erb :"transactions/showtrans"
  rescue
    puts "Exception!"
    erb :"/transactions/sorrypage"
  end
end

post '/trans/searchuser' do
  @transactions = TransactionDatabase.search_user(params[:em])
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
