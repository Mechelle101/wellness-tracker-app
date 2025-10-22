class NutritionLogsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_entry
  before_action :set_nutrition_log, only: [:edit, :update]
  
  # GET /entries/:entry_id/nutrition_logs
  def index
    @nutrition_logs = @entry.nutrition_logs.order(:meal_type, :created_at)
  end

  # GET /entries/:entry_id/nutrition_logs/new
  def new
    @nutrition_log = @entry.nutrition_logs.build(user_id: @entry.user_id)
  end

  # POST /entries/:entry_id/nutrition_logs
  def create
    @nutrition_log = @entry.build_log(nutrition_log_params)

    if @nutrition_log.save
      redirect_to entry_path(@entry), notice: "Nutrition log added."
    else
      flash.now[:alter] = "Please fix the errors."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /entries/:entry_id/nutrition_logs/:id/edit
  def edit; end

  # PATCH/PUT /entries/:entry_id/nutrition_logs/:id
  def update
    # enforces user_id if params try to change it
    if @nutrition_log.update(nutrition_log_params.merge(user_id: @entry.user_id))
      redirect_to entry_path(@entry), notice: "Nutrition log updated."
    else
      flash.now[:alert] = "Please fix the error."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user or return head :forbidden
  end

  def set_entry
    # this will scope the entry to the signed in user
    @entry = @user.entries.find(params[:entry_id])
  end

  def set_nutrition_log
    @nutrition_log = @entry.nutrition_logs.find(params[:id])
  end

  def nutrition_log_params
    params.require(:nutrition_log)
          .permit(:meal_type, :food_type, :calories, :protein_g, :carbs_g, :fats_g, :notes)
  end
end
