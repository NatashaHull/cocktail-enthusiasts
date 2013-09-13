class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  before_filter :logged_in_as_author, :only => [:edit, :destroy]

  # GET /comments/new
  # GET /comments/new.json
  
  def new
    @comment = Comment.new
    @topic = @comment.topic

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @topic = @comment.topic

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'Comment was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @topic = @comment.topic

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to topic_path(@topic), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to topic_path(@topic) }
      format.json { head :no_content }
    end
  end
  
  def logged_in_as_author
    comment = Comment.find(params[:id])
    @topic = comment.topic
    unless comment.logged_in_as_author(session[:user_id])
      redirect_to(view_comments_topic_path(@topic))
    end
  end
end
