class CreateWorkingLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :working_logs do |t|
      
      t.string :worktime_start
      t.string :worktime_end
      t.references :user, foreign_key: true
      t.references :partner, foreign_key: true
      t.string :address
      t.integer :cost, default: 0
      t.date :working_date
      t.integer :status, default: 0
      t.string :note, default: ''

      t.timestamps
    end
  end
end
