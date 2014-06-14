class UserMailer < ActionMailer::Base
  default from: 'invitation@example.com'

  def send_invitation(token, email)
    @token = token
    mail(to: email, subject: 'Visit our service now!')
  end
end
