class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def welcome_email(user)
    @user = user
    @url  = "http://eventbrite_remy.com/login"
    mail(to: @user.email, subject: "Bienvenue sur Eventbrite Remy !")
  end
end
