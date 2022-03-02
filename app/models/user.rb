class User < ApplicationRecord
  EMAIL_REGEX = Settings.regex.email.freeze

  validates :name, presence: true, length: {maximum: Settings.digits.digit_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.digit_255},
            format: {with: EMAIL_REGEX}, uniqueness: true
  validates :password_digest, presence: true,
            length: {minimum: Settings.digits.digit_6}

  before_save :downcase_email

  private

  has_secure_password

  def downcase_email
    email.downcase!
  end
end
