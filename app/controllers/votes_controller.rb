class VotesController < ApplicationController
  def create
    topic = Topic.find(params[:topic_id])
    # first, check if there are any existing votes from this ip!
    unless topic.votes.find_by_ip_address(request.remote_ip)
      vote = topic.votes.build(:ip_address => request.remote_ip)
      vote.save!
    end
    redirect_to(topics_path)
  end
  
  def subtract
    topic = Topic.find(params[:topic_id])
    vote = topic.votes.find_by_ip_address(request.remote_ip)
    if vote
      vote.destroy
    end
    redirect_to(topics_path)
  end
end