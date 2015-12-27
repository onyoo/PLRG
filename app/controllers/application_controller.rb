class ApplicationController < Sinatra::Base

configure do
  set :views, 'app/views/application/'
  enable :sessions
  set :session_secret, "try_to_pay_attention"
end

get '/' do
  #welcomes user @log-in page
  erb :index
end

end