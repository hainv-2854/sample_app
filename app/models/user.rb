class User < ApplicationRecord
  before_save :email_downcase

  validates :name,
            presence: true,
            length: {minimum: Settings.length.min_length_name}

  validates :email,
            presence: true,
            length: {maximum: Settings.length.max_length_email},
            format: {with: Settings.email.check_mail}

  validates :password,
            presence: true,
            length: {minimum: Settings.length.min_length_password}

  has_secure_password

  private
  def email_downcase
    email.downcase!
  end
end
