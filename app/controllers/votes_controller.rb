class VotesController < ApplicationController
  def upvote
    if !current_user.present?
      flash[:danger] = "You weren't signed in."
      redirect_to root_path
    end

    vote = Vote.find_by(user_id: current_user.id, event_id: params[:event_id])

    if (vote.present?)
      flash[:danger] = "Already voted for this!"
      redirect_to root_path
    else 
      vote = Vote.new
      vote.user_id = current_user.id
      vote.event_id = params[:event_id]

      if vote.save
        flash[:success] = "Successfully voted!"
        redirect_to root_path
      end
    end
  end
end
