require 'bcrypt'


class UserDatabase

  # Create a new user in the user database

  def self.create_user(fn, ln, em, un, pw)
    pw_salt = BCrypt::Engine.generate_salt
    pw_hash = BCrypt::Engine.hash_secret(pw, pw_salt)
    @user = User.create({:first_name => fn, :last_name => ln, :email => em, :username => un, :password => pw_hash, :salt => pw_salt})
  end

  # Find user by hs_id

  def self.find_by_hs_id(hs_id)
    User.find(:first, :conditions => ["hs_id = ?", hs_id])
  end

  # Authentication

  def self.authenticate(un, pw)
    @user = User.find(:first, :conditions => ["username = ?", un])
    return @user.password == BCrypt::Engine.hash_secret(pw, @user.salt)
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

  # Find ID of user by email

  def self.find_user(un)
    @user = User.find(:first, :conditions => ["username = ?", un])
    return @user
  end

  # Delete user

  def self.delete_user(un)
    @user = User.destroy(:first, :conditions => ["username = ?", un])
  end

end
