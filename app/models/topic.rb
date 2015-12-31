class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :resources

  def self.chain_delete(params)
    @topics = []
    params[:delete_topics].each{|k,v| @topics << Topic.find(k)}
    if @topics != [[]]
      @topics.each do |t|
        death_row = Resource.where(topic_id: t.id)
        Resource.delete(death_row)
      end
    end
    @topics.each{|t| Topic.delete(t.id)} unless @topics == [[]]
  end

  def self.find_environment(params)
    @topic = Topic.find(params[:id])
    @resources = Resource.where(topic_id: params[:id])
    @category = Category.find(@topic.category_id)
    {topic: @topic, resources: @resources, category: @category}
  end

end