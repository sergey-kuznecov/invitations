class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :show_notification_message

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :phone
  end

  def show_notification_message
    if user_signed_in? && current_user.phone_number_is_empty?
      flash[:alert] = 'Please enter the phone number in your profile!'
    end
  end
end
