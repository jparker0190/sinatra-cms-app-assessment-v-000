class BillsController < ApplicationController
  get "/bills" do
    redirect_if_not_logged_in
    @bill = Bills.all
    erb :'bills/index'
  end

  get "/bills/new" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'bills/new'
  end

  get "/bills/:id/edit" do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @bill = Bills.find(params[:id])
    erb :'bills/edit'
  end

  post "/bills/:id" do
    redirect_if_not_logged_in
    @bill = Bills.find(params[:id])
    unless Bills.valid_params?(params)
      redirect "/bills/#{@bill.id}/edit?error=invalid bill"
    end
    @bill.update(params.select{|k|k=="name" || k=="amount" || k=="property_id"})
    redirect "/bills/#{@bill.id}"
  end

  get "/bills/:id" do
    redirect_if_not_logged_in
    @bill = Bills.find(params[:id])
    erb :'bills/show'
  end

  post "/bills" do
    redirect_if_not_logged_in
    unless Bills.valid_params?(params)
      redirect "/bills/new?error=invalid bill"
    end
    Bills.create(params)
    redirect "/bills"
  end
end
Bills
