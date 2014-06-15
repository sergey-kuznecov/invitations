require 'spec_helper'

describe 'Invitation' do

  describe 'should send new invitation' do
    Given { visit root_path }
    Given { click_link 'Send Invitation' }
    Given { fill_in 'invitation[invitation_email]', with: 'example@gmail.com' }
    When  { click_button 'Send Invitation' }

    Then  { page.should have_content 'Your invitation has been sent successfully' }
  end

  describe 'should see validations messages' do
    Given { visit new_admin_invitation_path }

    context 'if invitation email is blank' do
      When  { click_button 'Send Invitation' }

      Then { find('#new_invitation').should have_content "can't be blank"  }
    end

    context 'if invitation email no valid' do

      When  { click_button 'Send Invitation' }
      Given { fill_in 'invitation[invitation_email]', with: 'awd@d' }

      Then { find('#new_invitation').should have_content 'is invalid'  }
    end
  end
end
