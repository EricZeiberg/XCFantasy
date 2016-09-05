class UsersController < ApplicationController

  def index
    @users = User.order_by(:points => 'desc')
  end

  def view
    @user = User.where(:name => params[:name]).first
    @races = Meet.all
  end

  def getPred
    @meet = Meet.find(params[:raceid])
    @user = User.where(:name => params[:name]).first
  end
end
