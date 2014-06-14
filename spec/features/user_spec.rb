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
    Given { edit_user_registration_path }
    When do
      within '.form-inputs' do
        fill_in 'user[email]', with: '+7000000000'
        fill_in 'user[password]', with: 'new_password'
        fill_in 'user[password_confirmation]', with: 'new_password'
        fill_in 'user[current_password]', with: 'password'
      end

      click_on 'Update'
    end

    Then { find('.alert-notice').should have_text 'You updated your account successfully.' }
  end
end