class CreateReminders < ActiveRecord::Migration[8.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message
      t.string :frequency
      t.string :time_of_day
      t.datetime :completed_at

      t.timestamps
    end
  end
end
