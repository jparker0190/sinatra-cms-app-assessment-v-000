require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

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
