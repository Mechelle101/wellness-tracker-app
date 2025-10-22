class Reminder < ApplicationRecord
  # --- Associations ---
  belongs_to :user

  # --- Validations ---
  validates :message, presence: true
  validates :frequency, 
            inclusion: { in: %w[daily weekly monthly hourly] }, 
            allow_nil: true
  validates :time_of_day, 
            format: { with: /\A\d{1,2}:\d{2}\z/, message: "must be HH:MM" }, 
            allow_nil: true

  # --- Scopes ---
  scope :incomplete, -> { where(completed_at: nil) }
  scope :ordered, -> { order(:time_of_day, :created_at) }

  # --- Instance Behavior ---
  def mark_completed!
    update!(completed_at: Time.current)
  end

  def completed?
    completed_at.present?
  end
end
