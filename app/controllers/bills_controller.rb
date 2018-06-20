class BillsController < ApplicationController
  get '/bills' do
    redirect_if_not_logged_in
    @bills = Bill.all
    erb :'bills/index'
  end
  get '/bills/new' do
    redirect_if_not_logged_in
    @error_mesasge = params[:error]
    erb :'bills/index'
  end
  get '/bills/:id/edit' do
    redirect_if_not_logged_in
    @error_mesasge = params[:error]
    erb :'bills/new'
  end
  post "/bills/:id" do
      redirect_if_not_logged_in
      @bill = Bill.find(params[:id])
      unless Bill.valid_params?(params)
        redirect "/bills/#{@bill.id}/edit?error=invalid bill"
      end
      @bill.update(params.select{|k|k=="name" || k=="amount"})
      redirect "/bills/#{@bill.id}"
  end
  get "/bills/:id" do
    redirect_if_not_logged_in
    @bill = Bill.find(params[:id])
    erb :'bills/show'
  end
  post "/bills" do
    redirect_if_not_logged_in
    unless Bill.valid_params?(params)
      redirect "/bills/new?error=invalid bill"
    end
    Bill.create(params)
    redirect "/bills"
  end
end
