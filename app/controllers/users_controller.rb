class UsersController < ApplicationController

  get "/users/index" do
    if logged_in?
      @users = User.all.sort_by{|word| word.username.downcase}
      erb :'/users/index'
    else
      redirect '/login'
    end
  end

get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/login'
    end
  end

  post "/signup" do
    if User.empty_signup?(params)
      erb :'/users/signup', :locals => {:message => "*** Please fill-in all fields. ***"}
    elsif !User.find_by(username: params[:username])
      @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name], member_status: "Little Grasshopper")
      login(@user)
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
      login(@user)

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
    if logged_in?
      @user = User.find(params[:id])
      @info = User.find_environment(params) # finds uniq categories, topics, and resources
      erb :'/users/show'
    else redirect '/login'
    end
  end

end