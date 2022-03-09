class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  default_scope{includes(:user, image_attachment: :blob)}
  scope :newest, ->{order created_at: :desc}

  validates :content, presence: true,
            length: {maximum: Settings.digits.digit_255}

  validates(:image,
            content_type: {in: Settings.image.accept_format,
                           message: I18n.t("microposts.invalid_img_type")},
            size: {less_than: Settings.image.max_size_mb.megabytes,
                   message: I18n.t("microposts.invalid_img_size")})

  def display_image
    image.variant(resize_to_limit: Settings.range_500)
  end
end
