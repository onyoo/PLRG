class ResourcesController < ApplicationController

  get "/resources/index" do
    if logged_in?
      @rights = rights(session)
      @resources = Resource.in_alphabetical_order
      erb :'/resources/index'
    else
      redirect '/login'
    end
    
  end

  get '/resources/:id/create' do
    if logged_in?
      @topic = Topic.find(params[:id])
      erb :'resources/create'
    end  
  end

  post "/resources/:id/create" do
    if logged_in?
      if Resource.not_empty?(params)
        Resource.create(name: params[:name], url: params[:url], description: params[:description], topic_id: params[:id], user_id: session[:id])
        User.check_upgrade(session)
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
      @rights = rights(session)
      @resource = Resource.find(params[:id])
      erb :'/resources/show'
    else redirect '/login'
    end
  end

  post "/resources/delete/:id" do
    if logged_in?
      Resource.delete_all(params)
      redirect "/topics/#{params[:id]}"
    end
  end

  get "/resources/edit/:id" do
    if logged_in?
      @resource = Resource.find(params[:id])
      erb :"/resources/edit"
    end
  end

  post "/resources/edit/:id" do
    r = Resource.update(params[:id], name: params[:new_name])
    redirect "/topics/#{r.topic_id}"
  end

  get "/resources/edit_details/:id" do
    if logged_in?
      @resource = Resource.find(params[:id])
      erb :"/resources/edit_details"
    end
  end

  post "/resources/edit_details/:id" do
    r = Resource.update(params[:id], name: params[:new_name], url: params[:new_url], description: params[:new_description])
    redirect "/topics/#{r.topic_id}"
  end

end