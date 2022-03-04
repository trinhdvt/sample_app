class User < ApplicationRecord
  EMAIL_REGEX = Settings.regex.email.freeze

  attr_accessor :remember_token

  validates :name, presence: true, length: {maximum: Settings.digits.digit_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.digit_255},
            format: {with: EMAIL_REGEX}, uniqueness: true
  validates :password_digest, presence: true,
            length: {minimum: Settings.digits.digit_6}

  before_save :downcase_email

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end

      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticate_token? remember_token
    return false if remember_digest.blank?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private

  def downcase_email
    email.downcase!
  end
end
