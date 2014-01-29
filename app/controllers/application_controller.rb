# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include HttpAcceptLanguage
  protect_from_forgery
  before_filter :set_locale

  private
  def set_locale
    I18n.locale = I18n.default_locale
  end
end
