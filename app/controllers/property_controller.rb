class PropertyController < ApplicationController
  get '/property' do
      if logged_in?
        @prop = Property.all
        erb :'properties/index'
      else
        redirect to '/login'
      end
    end

    get '/property/new' do
        if logged_in?
          erb :'properties/new'
        else
          redirect to '/login'
        end
      end

    post '/property' do
      if logged_in?
        if params[:name] == "" || params[:rooms] == ""
          redirect to "/property/new"
        else
          @prop = current_user.propertys.build(name: params[:name], rooms: params[:rooms])
          if @prop.save
            redirect to "/property/#{@prop.id}"
          else
            redirect to "/property/new"
          end
        end
      else
        redirect to '/login'
      end
    end

    get "/property/:id" do
      redirect_if_not_logged_in
      @prop = Property.find(params[:id])
      if @prop.user == current_user
      erb :'properties/show'
    else
      flash[:notice] = "You can't view this property"
      redirect to  '/property'
    end
    end

    get '/property/:id/edit' do
      redirect_if_not_logged_in
      @error_message = params[:error]
      @prop = Property.find(params[:id])
      erb :'properties/edit'
    end

    post "/property/:id" do
     redirect_if_not_logged_in
     @prop = Property.find(params[:id])
     unless Property.valid_params?(params)
       redirect "/property/#{@prop.id}/edit?error=invalid golf bag"
     end
     @prop.update(params.select{|k|k=="name" || k=="rooms"})
     redirect "/property/#{@prop.id}"

   end
    patch '/property/:id' do
      redirect_if_not_logged_in
      @prop = Property.find(params[:id])
      unless Property.valid_params?(params)
        redirect "/property/#{@prop.id}/edit?error=invalid property"
      end
      @prop.update(params.select{|k|k=="name" || k=="rooms"})
      redirect "/property/#{@prop.id}"
    end

    delete '/property/:id/delete' do
      if logged_in?
        @prop = Property.find_by_id(params[:id])
        if @prop && @prop.user == current_user
          @prop.delete
        end
        redirect to '/property'
      else
        redirect to '/login'
      end
    end
end
