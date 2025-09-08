class DashboardsController < ApplicationController

  # picking a user for manual testing
  before_action :set_user

  def show
    # todays entry if any
    @today_entry = @user.entries.find_by(date: Date.current)

    # last 7 days of macro totals (grouped by entry date)
    # includes only nutrition logs linked to the user & the entry
    @macro_by_day = NutritionLog
      .joins(:entry)
      .where(user_id: @user.id, entries: {user_id: @user.id})
      .where(entries: { date: (Date.current - 6.days)..Date.current })
      .group("entries.date")
      .select(
        "entries.date AS day",
        "COALESCE(SUM(calories),0) AS calories",
        "COALESCE(SUM(protein_g),0) AS protein_g",
        "COALESCE(SUM(carbs_g),0) AS carbs_g",
        "COALESCE(SUM(fats_g),0) AS fats_g",
      )

      # incomplete reminders
      @reminders = @user.reminders.where(completed_at: nil).order(:time_of_day)

      # current supplements
      @supplements = @user.supplements.order(:name)
  end

  private

  def set_user
    # replace this with current_user when adding auth
    @user = User.first! 
  end
end
