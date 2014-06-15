class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :token

      t.timestamps
    end

    add_index :invitations, :token, unique: true
  end
end
