class PropertyController < ApplicationController

  get "/property" do
    redirect_if_not_logged_in
    @bags = GolfBag.all
    erb :'golf_bags/index'
  end

  get "/property/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'properties/new'
  end

  get "/property/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @property = Property.find(params[:id])
    erb :'properties/edit'
  end

  post "/property/:id" do
    redirect_if_not_logged_in
    @property = Property.find(params[:id])
    unless Property.valid_params?(params)
      redirect "/property/#{@property.id}/edit?error=invalid property"
    end
    @property.update(params.select{|k|k=="name" || k=="rooms"})
    redirect "/property/#{@property.id}"
  end

  get "/property/:id" do
    redirect_if_not_logged_in
    @property = Property.find(params[:id])
    erb :'properties/show'
  end

  post "/property" do
    redirect_if_not_logged_in

    unless Property.valid_params?(params)
      redirect "/property/new?error=invalid property"
    end
    Property.create(params)
    redirect "/property"
  end
end
