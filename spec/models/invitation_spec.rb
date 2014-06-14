require 'spec_helper'

describe Invitation do

  describe '#generate_token' do
    When { @invitation = Invitation.create! }

    Then { @invitation.token.should_not be_nil }
  end
end
