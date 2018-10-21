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
