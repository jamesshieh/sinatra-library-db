class User < ActiveRecord::Base
  validates :first_name,:presence => true
  validates :email,     :presence => true,
                        :uniqueness => true
  validates :hs_id,     :presence => true,
                        :uniqueness => true
  has_many :transaction

  def self.find_by_hs_id(hs_id)
    self.find(:first, :conditions => ["hs_id = ?", hs_id])
  end


end

class Book < ActiveRecord::Base
  validates :title,     :presence => true

  has_many :booktag
  has_many :transaction
end

class Subject < ActiveRecord::Base
  validates :subject,   :presence => true

  has_many :booktag
end

class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
end

class Booktag < ActiveRecord::Base
  belongs_to :book
  belongs_to :subject
end
