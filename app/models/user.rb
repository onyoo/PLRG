class User < ActiveRecord::Base
  has_many :topics
  has_many :categories, through: :topics
  has_many :resources

has_secure_password

  def self.find_environment(params)
    user = self.find(params[:id])
      categories = []

      topics = user.topics.uniq
      resources = user.resources.uniq
      topics.each{|topic| categories << Category.find(topic.category_id)}

    {topics: topics, resources: resources, categories: categories}
  end

  def self.empty_signup?(params)
    params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:first_name] == ""
  end

  def self.check_upgrade(session)
    user = self.find(session[:id])
    user.member_status = "Legend" if user.resources.count > 2
    user.member_status = "Grand Master" if user.resources.count > 3
    user.save
  end
end