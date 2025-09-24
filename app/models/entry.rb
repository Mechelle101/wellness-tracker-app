class Entry < ApplicationRecord
  belongs_to :user
  has_many :nutrition_logs, dependent: :destroy
  has_many :entry_categories, dependent: :destroy
  has_many :categories, through: :entry_categories

  validates :date, presence: true, uniqueness: { scope: :user_id, message: "already has an entry for this user" }
end
