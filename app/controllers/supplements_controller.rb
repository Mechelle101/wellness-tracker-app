class SupplementsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_supplement, only: [:edit, :update, :destroy]

  def new
    @supplement = @user.supplements.build
  end

  def create
    @supplement = @user.supplements.build(supplement_params)
    if @supplement.save
      redirect_to dashboard_path, notice: "Supplement added."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @supplement.update(supplement_params)
      redirect_to dashboard_path, notice: "Supplement updated."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @supplement.destroy
    redirect_to dashboard_path, notice: "Supplement removed."
  end

  private

  def set_user
    @user = current_user or return head :forbidden
  end

  def set_supplement
    @supplement = @user.supplements.find(params[:id])
  end

  def supplement_params
    params.require(:supplement).permit(:name, :dosage, :frequency)
  end
end
