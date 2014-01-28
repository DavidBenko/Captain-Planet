# -*- encoding : utf-8 -*-

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  e_mail          :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ActiveRecord::Base

  has_secure_password

  validates :first_name,
            presence: true,
            length: { maximum: 255 }

  validates :last_name,
            presence: true,
            length: { maximum: 255 }

  validates :e_mail,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: Constants::E_MAIL_FORMAT }

  validates :password,
            length: { minimum: 6 },
            on: :create

  validates :password_confirmation,
            presence: true,
            on: :create

  before_save { e_mail.downcase! }
  before_save :create_remember_token

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
