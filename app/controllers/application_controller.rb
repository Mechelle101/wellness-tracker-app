class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
  end

  def require_login
    return if current_user

    respond_to do |format|
      format.html { redirect_to new_session_path, alert: "Please sign in." }
      format.any { head :forbidden }
    end
  end
end
