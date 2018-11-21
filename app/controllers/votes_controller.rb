class VotesController < ApplicationController
  def create
    if current_user.present?
      flash[:danger] = "You weren't signed in."
      redirect_to root_path
    end

    vote = Vote.new(vote_params)
    if vote.save
      flash[:success] = "Successfully voted!"
      redirect_to root_path
    end
  end

  private
  def vote_params
     params.require(:vote).permit(:user_id, :event_id)
  end
end
