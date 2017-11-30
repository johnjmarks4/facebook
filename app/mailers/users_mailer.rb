class UsersMailer < ApplicationMailer
  default from: 'facebookclone@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'http://rocky-earth-72993.herokuapp.com/users/login'
    mail(to: @user.email, subject: "Thank you for joining")
  end
end
