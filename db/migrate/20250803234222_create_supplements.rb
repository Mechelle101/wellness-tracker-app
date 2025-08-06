class CreateSupplements < ActiveRecord::Migration[8.0]
  def change
    create_table :supplements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :dosage
      t.string :frequency

      t.timestamps
    end
  end
end
