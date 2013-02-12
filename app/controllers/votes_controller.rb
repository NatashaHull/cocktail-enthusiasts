class VotesController < ApplicationController
  def create
    topic = Topic.find(params[:topic_id])
    user = User.find(session[:user_id])
    # first, check if there are any existing votes from this user!
    if (topic.votes & user.votes).empty?
      vote = topic.votes.build
      vote.user = user
      vote.save!
    end
    redirect_to(topics_path)
  end
  
  def subtract
    topic = Topic.find(params[:topic_id])
    user = User.find(session[:user_id])
    votes = topic.votes & user.votes
    if votes
      votes.first.destroy
    end
    redirect_to(topics_path)
  end
end