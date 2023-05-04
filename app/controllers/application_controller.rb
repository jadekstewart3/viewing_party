class ApplicationController < ActionController::Base
  helper_method :current_user
  add_flash_types :error, :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  def error_message(errors)
    errors.full_messages.join(", ")
  end
end
