require 'spec_helper'

describe Users::RegistrationsController do

  Given { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'GET #new' do

    Given { @invitation = create :invitation, invitation_email: 'example@gmail.com' }

    context 'with invitation token' do
      When { get :new }
      Then { response.should redirect_to root_path }
      And  { session[:token].should == nil }
    end

    context 'invitation token' do
      When { get :new, token: @invitation.token }
      Then { response.should be_success }
      And  { response.should render_template(:new) }
      And  { session[:token].should == @invitation.token }
    end
  end

  describe 'post #create' do
    context 'should destroy old invitation' do
      When { @invitation = create :invitation }
      When { controller.stub(:get_current_invitation).and_return(@invitation) }

      Then { expect{ post :create, user: { email: 'example@mail.com',  password: 'password', password_confirmation: 'password'} }.to change{ Invitation.count }.from(1).to(0) }
    end
  end


  describe 'PUT #update' do
    Given { @user = create :user, phone: nil }
    Given { sign_in @user }
    When { put :update, user: { phone: '3000000000', email: @user.email, current_password: 'password' } }

    Then { response.status.should == 302 }
    And  { response.should redirect_to root_path }
    And  { assigns(:user).phone.should == '3000000000' }
  end
end