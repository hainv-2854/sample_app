class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check_locale = I18n.available_locales.include?(locale)
    I18n.locale = check_locale ? locale : I18n.default_locale
  end
end
