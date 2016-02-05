class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views/'
    enable :sessions
    set :session_secret, "try_to_pay_attention"
  end

  get '/' do
    if logged_in?
      @user = User.find(session[:id])
    end
    erb :'/application/index'
  end


  private

  helpers do
    def logged_in?
      !!session[:id]
    end
    def login(user)
      session[:id] = user.id
    end
    def current_user
      User.find(session[:id])
    end

    def delete?(session)
      User.find(session[:id]).member_status == "Grand Master"
    end

    def edit?(session)
      User.find(session[:id]).member_status == "Grand Master" ||
      User.find(session[:id]).member_status == "Legend"
    end

    def create?(session)
      User.find(session[:id]).member_status == "Grand Master" ||
      User.find(session[:id]).member_status == "Legend" ||
      User.find(session[:id]).member_status == "Little Grasshopper"
    end

    def rights(session)
      if logged_in?
        create = true if create?(session)
        edit = true if edit?(session)
        delete = true if delete?(session)
        {create: create, edit: edit, delete: delete}
      else
        {create: false, edit: false, delete: false}
      end
    end
  end
end