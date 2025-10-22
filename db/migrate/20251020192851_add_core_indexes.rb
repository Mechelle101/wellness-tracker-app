class AddCoreIndexes < ActiveRecord::Migration[8.0]
  def change
    # user: unique email
    add_index :users, :email, unique: true

    # entries: 
    add_index :entries, [:user_id, :date]

    # reminders: incomplete by user
    add_index :reminders, [:user_id, :completed_at]

    # categories: unique names
    add_index :categories, :name, unique: true
  end
end
