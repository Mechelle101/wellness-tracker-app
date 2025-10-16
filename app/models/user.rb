class User < ApplicationRecord
  has_secure_password

  has_many :nutrition_logs, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supplements, dependent: :destroy
  has_many :reminders, dependent: :destroy

  # normalize email so it has case insensitivity
  before_validation { self.email = email.to_s.strip.downcase.presence }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true

  # setting a min length, but allow for other updates
  validates :password, length: { minimum: 8 }, allow_nil: true

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
