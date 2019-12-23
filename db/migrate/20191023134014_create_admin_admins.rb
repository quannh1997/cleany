class CreateAdminAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_admins do |t|
      t.string :name, default: 'Cleany Admin'
      t.string :email
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
    add_index :admin_admins, :email, unique: true
  end
end
