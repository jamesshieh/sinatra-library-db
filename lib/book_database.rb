require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'

class BookDatabase

  # Create a new book in the user database

  def self.create_book(t, fn, ln, descr)
    @book = Book.create({:author_first_name => fn, :author_last_name => ln, :title => t, :description => descr})
    if @user.save!
      puts "Save Successful"
    else
      puts "Save Failed!"
    end
  end

  # Edit an existing book in the user database

  def self.edit_book(id, t, fn, ln)
    @book = Book.update(id, :author_first_name => fn, :author_last_name => ln, :title => t)
    if @book.save!
      puts "Edit Successful!"
    else
      puts "Edit Failed!"
    end
  end

  # Search of database by title

  def self.search_book_title(t)
    @book = Book.where("title = ?", t)
    return @user
  end

  # Search of database by author

  def self.search_book_author(fn, ln)
    @book = Book.where("author_first_name = ? AND author_last_name = ?", fn, ln)
    return @book
  end

  # Find ID of book

  def self.find_user(t)
    @user = User.find(:first, :conditions => ["title = ?", t])
    return @user
  end

end
