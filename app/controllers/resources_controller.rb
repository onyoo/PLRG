class ResourcesController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/resources/index" do
    if logged_in?
      @create = 1 if create?(session)
      @edit = 1 if edit?(session)
      @delete = 1 if delete?(session)
      
      @resources = Resource.all
      erb :'/resources/index'
    else
      redirect '/login'
    end
    
  end


  get '/resources/:id/create' do
    if logged_in?
      @topic = Topic.find(params[:id]) #Coded also in  post "/resources/:id/create"
      erb :'resources/create'
    end  
  end

  post "/resources/:id/create" do
    if logged_in?
      if params[:name] != "" && params[:url] != "" && params[:description] != "" && params[:id] != ""
        Resource.create(name: params[:name], url: params[:url], description: params[:description], topic_id: params[:id])
        redirect "/topics/#{params[:id]}"
      else
        @topic = Topic.find(params[:id])
        erb :'resources/create', :locals => {:message => "*** All fields are mandatory. ***"}
      end
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

  post "/resources/delete/:id" do
    if logged_in?
      params[:delete_resources].each{|k,v| Resource.delete(k)}
      redirect "/topics/#{params[:id]}"
    end
  end

end