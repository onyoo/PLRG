class CategoriesController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/categories/index" do
    if logged_in?
      @create = 1
    end
    if session[:id] == 4
      @edit = 1
    end
    @categories = Category.all
    erb :'/categories/index'
  end

  get "/categories/create" do
    if logged_in?
      erb :'/categories/create'
    else redirect '/login'
    end
  end

  post "/categories/create" do
    if logged_in?
      Category.create(name: params[:name])
      redirect '/categories/index'
    else redirect '/login'
    end
  end

  get '/categories/:id' do
    if logged_in?
      @create = 1
    end
    if session[:id] == 4
      @edit = 1
    end
      @category = Category.find(params[:id])
      @topics = Topic.where(category_id: params[:id])
      erb :"/categories/show"
  end

  post "/categories/delete" do
    if logged_in?
      if params[:delete_categories] != {}
        @topics = []
        @resources = []

        params[:delete_categories].each{|k,v| @topics << Topic.find_by(category_id: k)}
        @topics.each{|t| @resources << Resource.where(topic_id: t.id)} unless @topics == [nil]

        binding.pry
        params[:delete_categories].each{|k,v| Category.delete(k)} 
        @topics.each{|t| Topic.delete(t.id)} unless @topics == [nil]
        @resources[0].each{|r| Resource.delete(r.id)} unless @resources == []
      end
      redirect "/categories/index"
    end
  end

end