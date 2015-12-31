class ApplicationController < Sinatra::Base
hi
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

    def current_user
      User.find(session[:id])
    end
  end

end