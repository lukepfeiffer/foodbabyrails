class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.with(user: user).confirmation_email.deliver_now
      flash[:success] = "You have created an account, an email was sent to confirm your status."
      redirect_to root_path
    else
      flash[:danger] = "Something went wrong...."
      redirect_to new_user_path
    end
  end

  def show
    if current_user.present? && current_user.id == params[:id].to_i
      @events = User.find(current_user.id).events
    else
      flash[:danger] = "You weren't signed in."
      redirect_to root_path
    end
  end

  def confirmation
    if params[:user_id].present?
      User.find(params[:user_id]).update(is_confirmed: true)
      flash[:success] = "Confirmed successfully! Sign in"
      redirect_to log_in_path
    else 
      flash[:danger] = "This user does not exist."
      redirect_to root_path
    end
  end

  def update
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :username
    )
  end
end
