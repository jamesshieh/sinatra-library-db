class User < ActiveRecord::Base
  validates_presence_of :first_name

  has_many :transaction
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
