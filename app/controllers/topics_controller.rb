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
      Topic.find_or_create_by(name: params[:name], category_id: params[:id], user_id: session[:id])
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

  private

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end
end