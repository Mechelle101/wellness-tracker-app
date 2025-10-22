class RemindersController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_reminder, only: [:edit, :update, :complete]

  # GET /users/:user_id/reminders/new
  def new
    @reminder = @user.reminders.build
  end

  # POST /users/:user_id/reminders
  def create
    @reminder = @user.reminders.build(reminder_params)
    if @reminder.save
      redirect_to dashboard_path, notice: "Reminder was created."
    else
      flash.now[:alert] = "Please fix the error below."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:user_id/reminders/:id/edit
  def edit; end

  # PATCH/PUT /users/:user_id/reminders/:id
  def update
    if @reminder.update(reminder_params)
      redirect_to dashboard_path, notice: "Reminder was updated."
    else
      flash.now[:alert] = "Please fix the error."
      render :edit, status: :unprocessable_entity
    end 
  end

  def complete
    @reminder = @user.reminders.find(params[:id])
    @reminder.mark_completed!
    redirect_to dashboard_path, notice: "Great job - reminder completed."
  end
  
  private

  def set_user
    @user = current_user or return head :forbidden
  end

  def set_reminder
    # scope to the signed in user to prevent cross-account access
    @reminder = @user.reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:message, :frequency, :time_of_day, :completed_at)
  end
end
