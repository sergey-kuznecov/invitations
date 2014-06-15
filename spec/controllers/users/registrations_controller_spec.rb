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


  describe 'POST #create' do



  end
end