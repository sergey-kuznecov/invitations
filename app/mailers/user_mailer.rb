class UserMailer < ActionMailer::Base
  default from: 'invitation@example.com'

  def send_invitation(invitation)
    @token = invitation.token
    mail(to: invitation.invitation_email, subject: 'Visit our service now!')
  end
end
