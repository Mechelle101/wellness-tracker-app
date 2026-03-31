class Supplement < ApplicationRecord
  belongs_to :user

  # --- Constants ---
  FREQUENCIES = %w[daily weekly monthly as_needed].freeze

  # --- Normalization  ---
  normalizes :name, with: ->(n) { n.to_s.squish.downcase.presence } rescue nil

  # --- Validations ---
  validates :name, presence: true, length: { maximum: 60 }
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :frequency, inclusion: { in: FREQUENCIES }, allow_nil: true
  validates :dosage, length: { maximum: 50 }, allow_nil: true

  # --- Scopes ---
  scope :ordered, -> { order(:name) }

end
