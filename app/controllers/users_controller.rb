class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(topics_path)
    else
      render 'new'
    end
  end

  def login
    user = User.find_by_name(params[:name][:name])
    if user && user.authenticate(params[:password][:password])
      session[:user_id] = user.id
      redirect_to(topics_path)
    else
      flash[:error] = "The user information you submitted is invalid."
      @user = User.new
      render 'new'
    end
  end
  
  def logout
    user = User.find_by_name(params[:name])
    session[:user_id] = nil
    redirect_to(topics_path)
  end
end
