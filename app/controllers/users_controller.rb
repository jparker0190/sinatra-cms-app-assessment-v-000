class UsersController < ApplicationController
  get '/users/:id' do
    if !logged_in?
      redirect '/bills'
  end
  @user = User.find(params[:id])
  if !@user.nil? && @user == current_user
    erb :'users/show'
  else
    redirect '/bills'
  end
end
  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/bills'
    end
  end
  get '/login' do
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/bills'
    end
  end
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenicate(params[:password])
      session[:user_id] = user.id
      redirect '/bills'
    else
      redirect to '/signup'
    end
  end
  get '/logout' do
    if session[:user_id] != nil
      session.destory
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
