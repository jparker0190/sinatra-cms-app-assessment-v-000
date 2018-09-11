class UsersController < ApplicationController
  get '/users/:slug' do
       @user = User.find_by_slug(params[:slug])
       erb :'users/show'
     end

     get '/signup' do
       if logged_in?
         redirect to '/property'
       else
         flash[:notice] = "That username is taken pick another"
         erb :'users/new'
       end
     end

     post '/signup' do
       @user = User.create(:username => params[:username],:password => params[:password])
       session[:user_id] = @user.id

       if logged_in?
         redirect to '/property'
       else

         redirect to '/signup'
       end
     end

     get '/login' do
       if !logged_in?

         erb :'users/login'
       else
         redirect to '/property'
       end
     end

     post '/login' do
       user = User.find_by(:username => params[:username])
       if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         redirect to "/property"
       else
         redirect to '/signup'
       end
     end

     get '/logout' do
       if logged_in?
         session.destroy
         redirect to '/login'
       else
         redirect to '/'
       end
     end
end
