class Entry < ApplicationRecord
  belongs_to :user
  has_many :nutrition_logs
  has_many :entry_categories
  has_many :categories, through: :entry_categories
end
