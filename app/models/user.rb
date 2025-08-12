class User < ApplicationRecord
  has_many :nutrition_logs
  has_many :entries
  has_many :supplements
  has_many :reminders

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
