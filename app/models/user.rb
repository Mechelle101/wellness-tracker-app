class User < ApplicationRecord
  has_many :nutrition_logs, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supplements, dependent: :destroy
  has_many :reminders, dependent: :destroy
end
