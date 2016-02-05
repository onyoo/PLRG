class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :resources, dependent: :destroy

  def self.in_alphabetical_order
    order(:name)
  end

  def self.delete_all(params)
    params[:delete_topics].each{ |k,v| Topic.destroy(k) }
  end

  def self.find_environment(params)
    topic = self.find(params[:id])
    {topic: topic, resources: topic.resources, category: topic.category}
  end

end
