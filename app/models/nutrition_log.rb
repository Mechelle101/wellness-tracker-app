class NutritionLog < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  validates :calories, :protein_g, :carbs_g, :fats_g,
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validate :user_matches_entry

  private
  
  def user_matches_entry
    return if entry && user_id == entry.user_id
    errors.add(:user_id, "must match the entry's user")
  end
end
