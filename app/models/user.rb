class User < ApplicationRecord
  has_many :nutrition_logs
  has_many :entries
  has_many :supplements
  has_many :reminders
end
