class ResourcesController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/resources/index" do
    if logged_in?
      @create
    end
    if session[:id] == 4
      @edit = 1
    end
    @resources = Resource.all
    erb :'/resources/index'
  end


  get '/resources/:id/create' do
    if logged_in?
      @topic = Topic.find(params[:id])
      erb :'resources/create'
    end  
  end

  post "/resources/:id/create" do
    if logged_in?
      Resource.create(name: params[:name], url: params[:url], description: params[:description], topic_id: params[:id])
      redirect "/topics/#{params[:id]}"
    else redirect '/login'
    end
  end

  get '/resources/:id' do
    if logged_in?
    @resource = Resource.find(params[:id])
    @topic = Topic.find(@resource.topic_id)
    erb :'/resources/show'
    else redirect '/login'
    end
  end

  post "/resources/delete" do
    if logged_in?
      binding.pry
      params[:delete_resources].each{|id| Topic.delete(id)}
      redirect "/categories/#{params[:id]}"
    end
  end

end