class NutritionLog < ApplicationRecord
  # --- Associations ---
  belongs_to :user
  belongs_to :entry

  # --- Validations ---
  validates :meal_type, presence: true
  validates :calories, :protein_g, :carbs_g, :fats_g,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validate :user_matches_entry

  # --- Scopes ---
  scope :recent_first, -> { order(created_at: :desc) }
  scope :by_meal_type, -> { order(:meal_type, :created_at) }

  private
  
  def user_matches_entry
    return if entry && user_id == entry.user_id
    errors.add(:user_id, "must match the entry's user")
  end
end
