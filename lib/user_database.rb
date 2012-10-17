class UserDatabase

  # Find user by hs_id

  def self.find_by_hs_id(hs_id)
    User.find(:first, :conditions => ["hs_id = ?", hs_id])
  end

  # Find ID of user by email

  def self.find_user(id)
    @user = User.find(id)
    return @user
  end

  # Delete user

  def self.delete_user(id)
    @user = User.destroy(:first, :conditions => ["id = ?", id])
  end

end
