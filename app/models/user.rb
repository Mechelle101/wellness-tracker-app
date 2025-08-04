class User < ApplicationRecord
  has_many :entries
  has_many :supplements
  has_many :reminders
end
