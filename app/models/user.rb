class User < ApplicationRecord
rspec-tests
  has_many :nutrition_logs
  has_many :entries
  has_many :supplements
  has_many :reminders

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  has_many :nutrition_logs, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supplements, dependent: :destroy
  has_many :reminders, dependent: :destroy
main
end
