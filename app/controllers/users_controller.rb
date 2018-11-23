class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      flash[:success] = "Created and signed in!"
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
      flash[:success] = "Confirmed successfully!"
      redirect_to root_path
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
