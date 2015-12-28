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

  post "/categories/delete/:id" do
    if logged_in?
      params[:delete_topics].each{|id| Topic.delete(id)}
      redirect "/categories/#{params[:id]}"
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