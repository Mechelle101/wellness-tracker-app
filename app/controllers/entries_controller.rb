class EntriesController < ApplicationController
  before_action :set_user
  before_action :set_entry, only: [:show, :edit, :update]

  # GET /entries
  def index
    @entries = @user.entries
    .left_joins(:nutrition_logs)
    .select("entries.*, COUNT(nutrition_logs.id) AS nutrition_count")
    .group("entries.id")
    .order(date: :desc)
  end

  # GET /entries/:id
  def show
    # @entry is set in the before action
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

  # GET /users/:user_id/entries/new
  def new
    @entry = @user.entries.build(date: Date.current)
  end

  # POST /users/:user_id/entries
  def create
    @entry = @user.entries.build(entry_params)
    @entry.date ||= Date.current
    if @entry.save
      redirect_to entry_path(@entry), notice: "Entry created."
    else
      flash.now[:alert] = "Please fix the error below."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /user/:user_id/entries/:id/edit
  def edit
    # @entry set in before action
  end

  # PATCH/PUT /user/:user_id/entries/:id
  def update
    if @entry.update(entry_params)
      redirect_to entry_path(@entry), notice: "Entry updated."
    else
      flash.now[:alert] = "Please fix the error below."
      render :edit, status: :unprocessable_entry
    end
  end

  private

  def set_user
    @user = current_user or return head :forbidden
  end

  def set_entry
    @entry = @user.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:date, :notes)
  end
end
