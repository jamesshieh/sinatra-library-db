require 'sinatra'
require 'sinatra/activerecord'
require './db/models.rb'

class BookDatabase

  # List all books and transaction status

  def self.get_catalog
    @book = Book.includes(:transaction)
    return @book
  end

  # Create a new book in the user database

  def self.new_book(ti, fn, ln, descr)
    @book = Book.create({:author_first_name => fn, :author_last_name => ln, :title => ti, :description => descr})
    if @book.save!
      puts "Save Successful"
    else
      puts "Save Failed!"
    end
    return @book
  end

  # Edit an existing book in the user database

  def self.edit_book(id, ti, fn, ln)
    @book = Book.update(id, :author_first_name => fn, :author_last_name => ln, :title => ti)
    if @book.save!
      puts "Edit Successful!"
    else
      puts "Edit Failed!"
    end
    return @book
  end

  # Search of database by title

  def self.search_book_title(ti)
    @book = Book.where("title = ?", ti)
    return @book
  end

  # Search of database by author

  def self.search_book_author(fn, ln)
    @book = Book.where("author_first_name = ? AND author_last_name = ?", fn, ln)
    return @book
  end

  # Find ID of book

  def self.find_book(t)
    @book = Book.find(:first, :conditions => ["title = ?", t])
    return @book
  end

end
