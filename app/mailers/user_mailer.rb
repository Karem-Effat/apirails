class UserMailer < ApplicationMailer
  def welcome_email(user)
  @user = user
#does not need to be functioning url to send to your user
   mail(to: @user.email, subject: 'Welcome ')
end
end
