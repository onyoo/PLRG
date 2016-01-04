class Category < ActiveRecord::Base
  has_many :topics

  def self.find_environment(params)
    category = Category.find(params[:id])
    topics = Topic.where(category_id: params[:id]).sort_by{|word| word.name.downcase}

    {category: category, topics: topics}
  end


  def self.chain_delete(params)
    categories = []
    resources = []
    topics = []

    params[:delete_categories].each{|k,v| topics << Topic.where(category_id: k)}
    topics.flatten!.each{|t| resources << Resource.where(topic_id: t.id)} unless topics == [nil]

    params[:delete_categories].each{|k,v| Category.delete(k)} 
    topics.each{|t| Topic.delete(t.id)} unless topics == [nil]
    resources[0].each{|r| Resource.delete(r.id)} unless resources == []
  end

end