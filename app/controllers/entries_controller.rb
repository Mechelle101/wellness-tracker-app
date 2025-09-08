class EntriesController < ApplicationController
  before_action :set_user

  def index
    @entries = @user.entries
    .left_joins(:nutrition_logs)
    .select("entries.*, COUNT(nutrition_logs.id) AS nutrition_count")
    .group("entries.id")
    .order(date: :desc)
  end

  def show
    @entry = @user.entries.find(params[:id])

    # preload relationships used in the view
    @categories = @entry.categories.order(:name)
    @nutrition_logs = @entry.nutrition_logs.order(:meal_type, :created_at)

    # simple totals
    @totals = @entry.nutrition_logs
      .select(
        "COALESCE(SUM(calories), 0) AS calories",
        "COALESCE(SUM(protein_g), 0) AS protein_g",
        "COALESCE(SUM(carbs_g), 0) AS carbs_g",
        "COALESCE(SUM(fats_g), 0) AS fats_g",
      ).take
  end

  private

  def set_user
    @user = User.first!
  end
end
