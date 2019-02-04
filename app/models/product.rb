class Product < ApplicationRecord
  has_many :cart_item

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :price, presence: true
  validates :inventory_count, presence: true
end
