class CategoriesController < ApplicationController

  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/categories/index" do
    @rights = rights(session)
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
    @rights = rights(session)
    @info = Category.find_environment(params)
    erb :"/categories/show"
  end

  post "/categories/delete" do
    if logged_in?
      if params[:delete_categories] != {}
        Category.chain_delete(params) # Deletes Category, Topics, and Resources owned by that Category
      end
      redirect "/categories/index"
    end
  end

end