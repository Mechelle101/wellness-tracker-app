class RemindersController < ApplicationController
  before_action :set_user
  before_action :set_reminder, only: [:edit, :update]

  # /users/:user_id/reminders/new
  def new
    @reminder = @user.reminders.build
  end

  # POST /user
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
  def edit
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.find(params[:id])
  end

  # PATCH/PUT /users/:user_id/reminders/:id
  def update
    @user = User.find(params[:user_id])
    @reminder = @user.reminders.find(params[:id])
    if @reminder.update(reminder_params)
      redirect_to dashboard_path, notice: "Reminder was updated."
    else
      flash.now[:alert] = "Please fix the error."
      render :edit, status: :unprocessable_entity
    end 
  end
  
  private
  def set_user
    @user = User.find(params[:user_id])

  end

  def set_reminder
    @reminder = @user.reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:message, :frequency, :time_of_day, :completed_at)
  end
end
