class CreateEntryCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :entry_categories do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :entry_categories, [:entry_id, :category_id], unique: true
  end
end
