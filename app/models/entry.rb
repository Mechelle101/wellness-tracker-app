class Entry < ApplicationRecord
  belongs_to :user
  has_many :nutrition_logs, dependent: :destroy
  has_many :entry_categories, dependent: :destroy
  has_many :categories, through: :entry_categories

  validates :date, presence: true, uniqueness: { scope: :user_id, message: "already has an entry for this user" }

  # --- Scope for readability ---
  scope :recent_first, -> { order(date: :desc, created_at: :desc) }
  scope :on,           ->(day) { where(date: day) }
  scope :between,      ->(range) { where(date: range) }
  scope :for_user,     ->(user) { where(user_id: user.is_a?(User) ? user.id : user) }

  # --- Instance behavior ---

  # Safe simple sums as a Ruby hash (should be easy to use in views)
  def macro_hash
    {
      calories:   nutrition_logs.sum(:calories)   || 0,
      protein_g:  nutrition_logs.sum(:protein_g)  || 0,
      carbs_g:    nutrition_logs.sum(:carbs_g)    || 0,
      fats_g:     nutrition_logs.sum(:fats_g)     || 0,
    }
  end

  # Individual helpers for views/tests
  def calories_total = macro_hash[:calories]
  def protein_total = macro_hash[:protein_g]
  def carbs_total = macro_hash[:carbs_g]
  def fats_total = macro_hash[:fats_g]

  # Ensuring logs alway match this entry's user (preventing cross user mistakes)
  def build_log(attrs = {})
    nutrition_logs.build(attrs.merge(user_id: user_id))
  end

  # For tags/pills in the UI
  def categories_list
    categories.order(:name).pluck(:name)
  end

  # --- Class behavior for dashboard/report queries ---
  
  # This returns rows like day: <Date>, calories: 123...
  def self.macro_totals_by_day_for(user, range)
    left_joins(:nutrition_logs)
      .where(user_id: user.id, date: range)
      .group("entries.date")
      .select(
        "entries.date AS day",
        "COALESCE(SUM(nutrition_logs.calories), 0) AS calories",
        "COALESCE(SUM(nutrition_logs.protein_g), 0) AS protein_g",
        "COALESCE(SUM(nutrition_logs.carbs_g), 0) AS carbs_g",
        "COALESCE(SUM(nutrition_logs.fats_g), 0) AS fats_g",
      )
  end

end
