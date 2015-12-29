class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :resources

end