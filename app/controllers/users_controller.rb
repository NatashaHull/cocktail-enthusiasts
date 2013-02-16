class UsersController < ApplicationController
  def login
    user = User.find_or_create_by_name(params[:name])
    session[:user_id] = user.id
    redirect_to(topics_path)
  end
  def logout
    user = User.find_or_create_by_name(params[:name])
    session[:user_id] = nil
    redirect_to(topics_path)
  end
end
