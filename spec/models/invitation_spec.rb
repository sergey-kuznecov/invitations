require 'spec_helper'

describe Invitation do
  it { should validate_presence_of :invitation_email }

  describe '#generate_token' do
    When { @invitation = Invitation.create(invitation_email: 'example@email.com') }

    Then { @invitation.token.should_not be_nil }
  end
end
