class NutritionLogsController < ApplicationController
  before_action :set_user
  before_action :set_entry
  
  def index
    @nutrition_logs = @entry.nutrition_logs.order(:meal_type, :created_at)
  end

  private

  def set_user
    @user = User.first!
  end

  def set_entry
    @entry = @user.entries.find(params[:entry_id])
  end
end
