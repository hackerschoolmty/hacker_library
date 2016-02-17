class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_i18n_locale_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def set_i18n_locale_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include? (params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] ="#{params[:locale]} translation not available"
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
