class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin
    redirect_to root_path, alert: "Permission Deniedd" unless current_user.admin?
  end

  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :avatar])
  end
end
