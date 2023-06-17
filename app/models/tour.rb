class Tour < ApplicationRecord
  after_save :update_status

  has_one_attached :image
  scope :with_attached_image, -> { includes(image_attachment: :blob) }

  def image_url
      if image.attached?
     Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
     else 
        nil
    end
  end

  belongs_to :user

  has_many :reservations, dependent: :destroy
  has_many :users

  validates :name, presence: true
  validates :city, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :video, presence: true

  def update_status
    update_column(:status, true)
  end

end
