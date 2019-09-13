class Product < ApplicationRecord
  has_many :users, through: :likes
  has_many :users, through: :messages
  has_many :users, through: :todoes
  has_many :users, through: :transactions
  has_many :product_images, dependent: :destroy
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :size, optional: true
  belongs_to :status
  belongs_to :condition
  has_one :delivery, dependent: :destroy
  accepts_nested_attributes_for :product_images, :delivery, allow_destroy: true
  has_many :users, through: :purchases
  has_many :purchases

  validate :product_product_images_number

  def product_product_images_number
    errors.add(:product_images, "を1枚以上投稿してください") if product_images.size < 1
    errors.add(:product_images, "は10枚までしか投稿できません") if product_images.size > 10
  end
end
