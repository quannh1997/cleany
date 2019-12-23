class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: {unique: true}
      t.string :phone
      t.string :address
      t.string :avatar, null: true
      t.string :password_digest
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.references :user, foreign_key: true
      t.references :partner, foreign_key: true

      t.timestamps
    end
  end
end
