class AddColumnToPartner < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :activation_digest, :string
    add_column :partners, :activated, :boolean, default: false
    add_column :partners, :remember_digest, :string
    add_column :partners, :reset_digest, :string
    add_column :partners, :reset_sent_at, :datetime
  end
end
