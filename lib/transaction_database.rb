require 'time'

class TransactionDatabase

  # List all active transactions

  def self.get_active_transactions
    @transaction = Transaction.find(:all, :conditions => ["active_flag = 't'"])
    return @transaction
  end

  # List all active and inactive transactions

  def self.get_all_transactions
    @transaction = Transaction.find(:all)
    return @transaction
  end

  # Check out a book by opening a transaction

  def self.checkout_book(ti, id)
    # To account for blanks returning false when looking for NOT IN [""]
    @missingbooks = ['null']
    @activetransactions = self.get_active_transactions
    @activetransactions.each do |transaction|
      @missingbooks << transaction.book_id
    end
    @book = Book.find(:first, :include => :transaction, :conditions => ["(books.id NOT IN (?)) AND title = ?", @missingbooks, ti])
    @transaction = Transaction.create({ :book_id => @book.id, :user_id => id, :open_date => Time.now })
    return @transaction
  end

  # Return a book and close transaction

  def self.return_book(ti, id)
    @book = Book.find(:first, :include => :transaction, :conditions => ["transactions.active_flag = 't' AND title = ? AND transactions.user_id = ?", ti, id])
    @transaction = Transaction.find(:first, :conditions => ["book_id = ? AND user_id = ? AND active_flag = 't'", @book.id, id])
    Transaction.update(@transaction.id, :active_flag => false, :closed_date => Time.now)
    @transaction = Transaction.find(@transaction.id)
    return @transaction
  end

  # Search transactions by user

  def self.search_user(id)
    @transaction = Transaction.find(:all, :include => :user, :conditions => ["users.id = ?", id])
    return @transaction
  end

  # Search transactions by book

  def self.search_book(ti)
    @transaction = Transaction.find(:all, :include => :book, :conditions => ["books.title =?", ti])
    return @transaction
  end

end
