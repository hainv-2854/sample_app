class User < ApplicationRecord
  before_save :email_downcase
  attr_accessor :remember_token

  validates :name,
            presence: true,
            length: {in: Settings.length.digit_6..Settings.length.digit_50}

  validates :email,
            presence: true,
            length: {maximum: Settings.length.digit_150},
            format: {with: Settings.email.check_mail}

  validates :password,
            presence: true,
            length: {minimum: Settings.length.digit_3},
            allow_nil: true

  has_secure_password

  scope :sort_by_name, ->{order :name}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end

  private
  def email_downcase
    email.downcase!
  end
end
