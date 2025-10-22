class HardenSupplementsUniquenessAndNulls < ActiveRecord::Migration[8.0]
  def change
    # name must be present
    change_column_null :supplements, :name, false

    # case-insensitive uniqueness of name per user
    remove_index :supplements, [:user_id, :name] if index_exists?(:supplements, [:user_id, :name])
    add_index :supplements, [:user_id, :name], unique: true
  end
end
