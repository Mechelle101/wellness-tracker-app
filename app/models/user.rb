class User < ApplicationRecord
  has_secure_password

  # --- Associations ---
  has_many :nutrition_logs, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :supplements, dependent: :destroy
  has_many :reminders, dependent: :destroy

  # --- Email Normalization ---
  # run before validation, lowercase and trim emails
  before_validation { self.email = email.to_s.strip.downcase.presence }

  # --- Validations ---
  validates :email, 
    presence: true, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  # setting a min length, but allow for other updates
  validates :password, length: { minimum: 8, maximum: 72 }, allow_nil: true

  # --- Model Behavior ---
  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
