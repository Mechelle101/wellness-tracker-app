class Entry < ApplicationRecord
  belongs_to :user
  has_many :nutrition_logs, dependent: :destroy
  has_many :entry_categories, dependent: :destroy
  has_many :categories, through: :entry_categories
end
