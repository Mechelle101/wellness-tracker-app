class HardenNullConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :entries, :date, false
    change_column_null :users, :password_digest, false
    change_column_null :reminders, :message, false
  end
end
