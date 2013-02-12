class UsersController < ApplicationController
  def login
    user = User.find_or_create_by_name(params[:name])
    session[:user_id] = user.id
    redirect_to(topics_path)
  end
end
