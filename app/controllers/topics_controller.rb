class TopicsController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/topics/index" do
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
    if logged_in?
      @rights = rights(session)
      @info = Topic.find_environment(params) #returns all categories, topics, and resources in a hash
      erb :'/topics/show'
    else redirect '/login'
    end
  end

  post "/topics/delete/:id" do
    if logged_in?
      Topic.chain_delete(params) # Deletes Topic and Resources owned by that Topic
      redirect "/categories/index"
    end
  end

end