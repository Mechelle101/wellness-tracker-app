class UsersLowerEmailUniqueIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, :email
    add_index :users, "LOWER(email)", unique: true, name: "index_users_on_lower_email"
  end
end
