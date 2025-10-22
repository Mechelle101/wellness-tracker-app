class DashboardsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show
    # protects access
    return head :forbidden unless @user

    # todays entry if any
    @today_entry = @user.entries.find_by(date: Date.current)

    # last 7 days of macros 
    range = (Date.current - 6.days)..Date.current
    @macro_by_day = Entry.macro_totals_by_day_for(@user, range)

    # incomplete reminders + supplements
    @reminders = current_user.reminders.incomplete.ordered
    @supplements = current_user.supplements.order(:name)
  end

  private

  def set_user
    @user = current_user
  end
end
