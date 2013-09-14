class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:user][:old_password]) && params[:user][:password] == params[:user][:password_confirmation]
      @user.update_attributes(name: @user.name, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      respond_to do |format|
        format.html { redirect_to topics_path, notice: 'Your password was successfully changed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "The user information you submitted is invalid."
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @topics = @user.topics.sort_by { |topic| topic.title.downcase }
    @comments = @user.comments.select {|comment| comment.topic }
                              .sort_by { |comment| comment.topic.title.downcase }
    @votes = @user.votes.sort_by { |vote| Topic.find(vote.topic_id).title.downcase }
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
