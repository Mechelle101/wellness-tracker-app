class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    # render login form
  end

  def create
    user = User.authenticate_by(email: params[:email].to_s.downcase.strip, password: params[:password])

    if user
      reset_session
      session[:current_user_id] = user.id
      redirect_to dashboard_path, notice: "Signed in."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Signed out."
  end
end
