class User < ActiveRecord::Base
  has_many :topics
  has_many :categories, through: :topics
  has_many :resources, through: :topics

has_secure_password

end