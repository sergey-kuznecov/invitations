require 'spec_helper'

describe Admin::InvitationsController do

  Given { ActionMailer::Base.deliveries = [] }

  describe 'POST #create' do
    When { post :create, invitation: { invitation_email: 'example@gmail.com' } }

    Then { response.status.should == 302 }
  end

  describe 'should send intivation email' do
    Then { expect{ post :create, invitation: { invitation_email: 'example@gmail.com' } }.to change{ ActionMailer::Base.deliveries.count }.from(0).to(1) }
  end
end

