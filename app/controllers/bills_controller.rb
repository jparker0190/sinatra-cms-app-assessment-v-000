class BillsController < ApplicationController
  enable :sessions
  use Rack::Flash
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/bills' do
    @bill = Bill.all
    erb :"bills/index"
  end

  get '/bills/new' do
    @prop = Property.all
    erb :"bills/new"
  end

  post '/bills' do
    @bill = Bill.create(:name => params[:bill][:name])

    user_entry = params[:bill][:user]
    if User.find_by(:name => user_entry)
      user = User.find_by(:name => user_entry)
    else
      user = User.create(:name => user_entry)
    end
    @bill.user = user

    property_selections = params[:bill][:properties]
    property_selections.each do |property|
      @bill.property << Property.find(property)
    end

    @bill.save

    flash[:message] = "Successfully created bill."
    redirect to "bills/#{@bill.slug}"

  end

  get '/bills/:slug' do
    slug = params[:slug]
    @bill = Bill.find_by_slug(slug)
    erb :"bills/show"
  end

  patch '/bills/:slug' do
    bill = Bill.find_by_slug(params[:slug])
    bill.name = params[:bill][:name]

    user_name = params[:bill][:user]
    if User.find_by(:name => user_name)
      if bill.user.name != user_name
        bill.user = User.find_by(:name => user_name)
      end
    else
      bill.user = User.create(:name => user_name)
    end

    if bill.prop
      bill.prop.clear
    end
    props = params[:bill][:properties]
    props.each do |prop|
      prop.bills << Property.find(prop)
    end

    bill.save
    flash[:message] = "Successfully updated bill."
    redirect to "bills/#{bill.slug}"
  end

  get '/bills/:slug/edit' do
    slug = params[:slug]
    @bill = Bill.find_by_slug(slug)
    erb :"bills/edit"
  end
end
