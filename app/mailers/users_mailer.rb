class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirm_email
    @user = params[:user]
    @url  = confirm_path
    mail(to: @user.email, subject: 'Account confirmation')
  end
end
