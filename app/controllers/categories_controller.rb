class CategoriesController < ApplicationController


  get "/categories/index" do
    @rights = rights(session)
    @categories = Category.in_alphabetical_order
    erb :'/categories/index'
  end

  get "/categories/create" do
    if logged_in?
      binding.pry
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
    @category = Category.find(params[:id])
    erb :"/categories/show"
  end

  post "/categories/delete" do
    if logged_in?
      if params[:delete_categories] != {}
        Category.delete_all(params)  # Deletes each category from form
      end
      redirect "/categories/index"
    end
  end

  get "/categories/edit/:id" do
    if logged_in?
      @category = Category.find(params[:id])
      erb :"/categories/edit"
    end
  end

  post "/categories/edit/:id" do
    Category.update(params[:id], name: params[:new_name])
    redirect "/categories/index"
  end

end