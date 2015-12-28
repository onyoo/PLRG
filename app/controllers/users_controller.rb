class UsersController < ApplicationController


  def slug
    self.name.gsub(/\ /,"-").downcase
  end

  get "/users/index" do
    if logged_in?
      @create
    end
    @users = User.all
    erb :'/users/index'
  end

get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/login'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:first_name] == ""
      erb :'/users/signup', :locals => {:message => "*** Please fill-in all fields. ***"}
    elsif !User.find_by(username: params[:username])
      @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name], member_status: "Little Grasshopper")
      session[:id] = @user[:id]
      redirect "/"
    else
      erb :'/users/signup', :locals => {:message => "*** It seems that username already exists. Try logging-in? ***"}
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user[:id]
      redirect "/"
    else
      erb :'/users/login', :locals => {:message => "*** The username and password provided do not match. Please try again. ***"} 
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

    get '/users/:id' do
    if session[:id] == 4
      @edit = 1
    end
    if logged_in?
      @categories = []
      @resources = []
      @user = User.find(params[:id])

      @topics = Topic.where(user_id: @user.id)
      @topics.each{|topic| @categories << Category.find(topic.category_id)}
      @topics.each{|topic| @resources << Resource.find_by(topic_id: topic.id)}
    
    erb :'/users/show'
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