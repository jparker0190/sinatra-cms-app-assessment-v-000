require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "billsarentfun"
  end

  get '/' do
    erb :index
    #Let's pay Bill!!
  end
  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=Please login a little"
      end
    end
    def logged_in?
      !!session[:user_id]
    end
    def current_user
      User.find(session[:user_id])
    end
  end
end
