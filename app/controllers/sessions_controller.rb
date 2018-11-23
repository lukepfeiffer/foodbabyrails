class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.is_confirmed
        sign_in(user)
        flash[:success] = "Signed in successfully!"
        redirect_to root_path
      else
        flash[:warning] = "You must confirm your account."
        redirect_to log_in_path
      end
    else
      flash[:danger] = "Email or password did not match!"
      redirect_to log_in_path
    end
  end

  def destroy
    sign_out_user
    flash[:success] = "Sign out successful!"
    redirect_to :root
  end
end
