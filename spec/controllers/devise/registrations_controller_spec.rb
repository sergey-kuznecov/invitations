require 'spec_helper'

describe Devise::RegistrationsController do

  Given { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'PUT #update' do
    Given { @user = create :user, phone: nil }
    Given { sign_in @user }
    When { put :update, user: { phone: '3000000000', email: @user.email, current_password: 'password' } }

    Then { response.status.should == 302 }
    And  { response.should redirect_to root_path }
    And  { assigns(:user).phone.should == '3000000000' }
  end
end