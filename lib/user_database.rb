class UserDatabase

  # Create a new user in the user database

  def self.create_user(fn, ln, em)
    @user = User.create({:first_name => fn, :last_name => ln, :email => em})
    if @user.save!
      puts "Save Successful"
    else
      puts "Save Failed!"
    end
  end

  # Edit an existing user in the user database

  def self.edit_user(id, fn, ln, em)
    @user = User.update(id, :first_name => fn, :last_name => ln, :email => em)
    if @user.save!
      puts "Edit Successful!"
    else
      puts "Edit Failed!"
    end
  end

  # Find user by First/Last

  def self.search_user(fn, ln)
    @user = User.where("first_name = ? AND last_name = ?", fn, ln)
    return @user
  end

  # Find ID of user by email

  def self.find_user(em)
    @user = User.find(:first, :conditions => ["email = ?", em])
    return @user
  end

  def self.delete_user(id)
    @user = User.destroy(id)
  end

end
