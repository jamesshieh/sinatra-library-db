require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'

set :database, 'sqlite3:///database.db'

User.create([{ :email => "test@test.com", :first_name => "test", :last_name => "test" }])

get '/' do
  "Hello there"
end

get '/users' do
  @users = User.all
  erb :index
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :show
end
