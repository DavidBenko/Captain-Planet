# -*- encoding : utf-8 -*-
#noinspection RailsParamDefResolve
class Session
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :e_mail, :password

  validates_presence_of :e_mail, :password
  validates_format_of :e_mail, with: Constants::E_MAIL_FORMAT

  def initialize(e_mail = nil, password = nil)
    @e_mail = e_mail
    @password = password
  end

  def authenticate
    user = User.find_by_e_mail(@e_mail)
    auth_ok = user && user.authenticate(@password)
    auth_ok ? user : nil
  end

  def persisted?
    false
  end

end
