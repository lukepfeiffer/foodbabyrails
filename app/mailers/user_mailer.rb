class UserMailer < ApplicationMailer
  default from: ENV['EMAIL_USERNAME']

  def confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Account confirmation')
  end
end
