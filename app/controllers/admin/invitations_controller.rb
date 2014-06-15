class Admin::InvitationsController < ApplicationController
  inherit_resources
  respond_to :html

  def create
    create! do |success, failure|
      success.html do
        if UserMailer.send_invitation(resource).deliver
          flash[:notice] = 'Your invitation has been sent successfully'
        else
          flash[:error] = 'Error while sending message. Please retry later!'
        end
          redirect_to admin_root_path
        end
      failure.html { render :new }
    end
  end

  def permitted_params
    params.permit(invitation: [:invitation_email])
  end
end