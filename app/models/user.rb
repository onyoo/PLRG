class User < ActiveRecord::Base
  has_many :topics
  has_many :categories, through: :topics
  has_many :resources, through: :topics

has_secure_password

  def self.find_environment(params)
    user = User.find(params[:id])
      categories = []

      topics = user.topics.uniq
      resources = user.resources.uniq
      topics.each{|topic| categories << Category.find(topic.category_id)}

    {topics: topics, resources: resources, categories: categories}
  end

end