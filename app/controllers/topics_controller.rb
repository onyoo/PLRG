class TopicsController < ApplicationController


  get "/topics/index" do
    @topics = Topic.in_alphabetical_order
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
      @topic = Topic.find(params[:id]) #returns all categories, topics, and resources in a hash
      erb :'/topics/show'
    else redirect '/login'
    end
  end

  post "/topics/delete/:id" do
    if logged_in?
      Topic.delete_all(params) # Deletes all Topics and Resources owned by that Topic
      redirect "/categories/#{params[:id]}"
    end
  end

  get "/topics/edit/:id" do
    if logged_in?
      @topic = Topic.find(params[:id])
      erb :"/topics/edit"
    end
  end

  post "/topics/edit/:id" do
    t = Topic.update(params[:id], name: params[:new_name])
    redirect "/categories/#{t.category_id}"
  end

end