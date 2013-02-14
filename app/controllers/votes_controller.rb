class VotesController < ApplicationController
  def create
    topic = Topic.find(params[:topic_id])
    user = User.find(session[:user_id])
    # first, check if there are any existing votes from this user!
    if topic.votes_by_user_id(session[:user_id]).empty?
      vote = topic.votes.build
      vote.user = user
      vote.save!
    end
    redirect_to(topics_path)
  end

  def subtract
    topic = Topic.find(params[:topic_id])
    vote = topic.votes_by_user_id(session[:user_id]).first rescue nil
    if vote
      vote.destroy
    end
    redirect_to(topics_path)
  end
end
