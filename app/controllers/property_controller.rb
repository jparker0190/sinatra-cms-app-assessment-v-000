class PropertyController < ApplicationController
  register Sinatra::ActiveRecordExtension
set :session_secret, "my_application_secret"
set :views, Proc.new { File.join(root, "../views/") }

get '/property' do
  @prop = Property.all
  erb :"properties/index"
end

get '/property/:slug' do
  slug = params[:slug]
  @prop = Property.find_by_slug(slug)
  erb :"properties/show"
end
end
