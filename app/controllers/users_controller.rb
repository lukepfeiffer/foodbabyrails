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
      error_messages = ""

      user.errors.each do |attribute, message|
        error_messages += "#{attribute.capitalize}: #{message}, "
      end
      flash[:danger] = error_messages
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
    user = User.find_by_confirmation_token(params[:id])

    if user
      user.email_activate
      flash[:success] = "Confirmed successfully! Sign in"
      redirect_to sign_in_path
    else
      flash[:danger] = "Unable to find matching user..."
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
