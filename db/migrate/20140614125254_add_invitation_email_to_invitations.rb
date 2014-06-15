class AddInvitationEmailToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invitation_email, :string
  end
end
