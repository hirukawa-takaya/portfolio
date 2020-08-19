class UserMailer < ApplicationMailer
  default from: 'no-replay@gmail.com'

  def complete_mail
    @share = params[:share]
    @url = params[:url]
    mail(subject: "リンクが届きました" ,to: @share )
  end
end