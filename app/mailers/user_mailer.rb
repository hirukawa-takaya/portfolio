class UserMailer < ApplicationMailer
  default from: 'portfoliomailer5@gmail.com'

  def complete_mail(user)
    @user = user
    @url = "http://localhost:3000/users/#{@user.id}"
    mail(subject: "COMPLETE join your address" ,to: @user.email)
  end
end