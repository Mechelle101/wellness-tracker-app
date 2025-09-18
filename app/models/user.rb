class User < ApplicationRecord
  has_secure_password

  has_many :nutrition_logs, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supplements, dependent: :destroy
  has_many :reminders, dependent: :destroy

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
