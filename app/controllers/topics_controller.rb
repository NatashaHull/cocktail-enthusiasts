class TopicsController < ApplicationController
  before_filter :logged_in_as_author, :only => [:edit, :destroy]
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all.sort_by {|topic| topic.title.downcase}
    @ip = request.remote_ip

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    if session[:user_id]
      @topic.user = User.find(session[:user_id])
    end

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end
  
  def view_comments
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    
    render 'comments/index'
  end
  
  def new_comment
    @topic = Topic.find(params[:id])
    @comment = @topic.comments.build
    
    render 'comments/new'
  end
  
  def create_comment
     @comment = Comment.new(params[:comment])
    @topic = @comment.topic

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @topic, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def logged_in_as_author
    topic = Topic.find(params[:id])
    unless topic.logged_in_as_author(session[:user_id])
      redirect_to(topics_path)
    end
  end
  
  def compare
    @topics = Topic.all.sort_by {|topic| topic.title.downcase}
    @ip = request.remote_ip

    respond_to do |format|
      format.html # compare.html.erb
      format.json { render json: @topics }
    end
  end
  
  def compare_show
    cocktail_nums = params.select {|k,v| k.include? 'cocktail'}
    @topics = cocktail_nums.map {|k,v| Topic.find(k.split('.')[1].to_i) }
    @width_pct = 100. / cocktail_nums.count rescue nil
  end
end