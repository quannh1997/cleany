class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :district
      t.string :city
      t.string :avatar, null: true
      t.string :worktime_start
      t.string :worktime_end
      t.integer :cost, default: 0
      t.string :description
      t.datetime :activated_at
      t.timestamps
    end
    add_index :partners, :email, unique: true
  end
end
