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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  private
  def email_downcase
    email.downcase!
  end
end
