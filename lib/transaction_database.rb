require 'time'

class TransactionDatabase

  # List all active transactions

  def self.get_active_transactions
    @transaction = Transaction.where("active_flag = true")
    return @transaction
  end

  # List all active and inactive transactions

  def self.get_active_transactions
    @transaction = Transaction.all
    return @transaction
  end

  # Check out a book by opening a transaction

  def self.checkout_book(ti, em)
    @user = User.find("email = ?", em)
    @book = Book.find(:first, :conditions => ["active_flag = false AND title = ?", ti])
    @transaction = Transaction.create({ :book_id => @book.id, :user_id => @user.id, :open_date => Time.now })
    return @transaction
  end

  # Return a book and close transaction

  def self.return_book(ti, em)
    @user = User.find("email = ?", em)
    @book = Book.find("active_flag = true AND title = ? AND user_id = ?", ti, @user.id)
    @transaction = Transaction.find(:first, :conditions => ["book_id = ? AND user_id = ?", @book.id, @user.id])
    Transaction.update(@transaction.id, :active_flag => false, :closed_date => Time.now)
    @transaction = Transaction.find(@transaction.id)
  end

end
