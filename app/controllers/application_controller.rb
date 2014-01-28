# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include HttpAcceptLanguage
  protect_from_forgery
  before_filter :set_locale

  private
  def set_locale
    if Rails.env.development?
      I18n.locale = :ru
    else
      preferred_locale = preferred_language_from I18n.available_locales
      I18n.locale = preferred_locale || I18n.default_locale
    end
    logger.debug "Using locale: #{I18n.locale}"
  end
end
