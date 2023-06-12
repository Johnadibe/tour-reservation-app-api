class Tour < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :city, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :video, presence: true
end
