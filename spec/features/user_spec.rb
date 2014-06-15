require 'spec_helper'

describe 'User' do

  Given { @user = create :user, email: 'example@mail.com' }

  describe 'must be logged' do
    Given { visit root_path }
    Given { click_link 'Sign in' }
    When do
      within '#new_user' do
        fill_in 'user[email]', with: 'example@mail.com'
        fill_in 'user[password]', with: 'password'
      end
      click_button 'Sign in'
    end

    Then { find('.alert-notice').should have_text '×Signed in successfully.' }
  end

  describe 'must have successfully logged out' do
    Given { login_as_user(@user) }
    Given { visit root_path }
    Given { click_link 'Sign Out' }

    Then { find('.alert-notice').should have_text '×Signed out successfully.' }
  end

  describe 'must successfully update the profile' do
    Given { login_as_user(@user) }
    Given { visit edit_user_registration_path }
    When do
      within '.form-inputs' do
        fill_in 'user[phone]', with: '+7000000000'
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        fill_in 'user[current_password]', with: 'password'
      end

      click_button 'Update'
    end

    Then { find('.alert-notice').should have_text 'You updated your account successfully.' }
  end

  describe 'should be sent to the home page' do
    When { visit new_user_registration_path  }

    Then { page.should have_content 'Landing page' }
    And { page.should have_content 'In order to register, you should get an invitation!' }
  end

  describe 'should be able to register for invitation' do
    Given { UserMailer.deliveries = [] }
    Given { visit root_path }
    Given { click_link 'Send Invitation' }
    Given { fill_in 'invitation[invitation_email]', with: 'example@gmail.com' }
    When  { click_button 'Send Invitation' }

    When { @invitation_url = /http:([^"]*)/.match(UserMailer.deliveries.first.body.raw_source).to_s }
    When { visit @invitation_url }
    When do
      within '#new_user' do
        fill_in 'user[email]', with: 'other_email@mail.ru'
        fill_in 'user[password]', with: 'password1'
        fill_in 'user[password_confirmation]', with: 'password1'
        click_button 'Sign up'
      end
    end
    Then { page.should have_content 'Welcome! You have signed up successfully.' }
    And  { page.should have_link 'Profile' }
  end

end