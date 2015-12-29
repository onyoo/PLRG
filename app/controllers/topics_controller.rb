class TopicsController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/topics/index" do
    if logged_in?
      @create
    end
    @topics = Topic.all
    erb :'/topics/index'
  end

  get "/topics/:id/create" do
    if logged_in?
      @category = Category.find(params[:id])
      erb :'/topics/create'
    else redirect '/login'
    end
  end

  post "/topics/:id/create" do
    if logged_in?
      Topic.create(name: params[:name], category_id: params[:id], user_id: session[:id]) unless Topic.find_by(name: params[:name])
      redirect "/categories/#{params[:id]}"
    else redirect '/login'
    end
  end

  get '/topics/:id' do
    if session[:id] == 4
      @edit = 1
    end
    if logged_in?
    @topic = Topic.find(params[:id])
    @resources = Resource.where(topic_id: params[:id])
    @category = Category.find(@topic.category_id)
    erb :'/topics/show'
    else redirect '/login'
    end
  end

  post "/topics/delete/:id" do
    if logged_in?

      @topics = []
      @resources = []

      params[:delete_topics].each{|k,v| @topics << Topic.find(k)}

      if @topics != [[]]
        @topics.each do |t|
          death_row = Resource.where(topic_id: t.id)
          Resource.delete(death_row)
        end
      end
      
      @topics.each{|t| Topic.delete(t.id)} unless @topics == [[]]

      redirect "/categories/index"
    end
  end

end