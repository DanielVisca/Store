class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  

  validates :product_id, presence: true
  validates :cart_id, presence: true
  validates :quantity, presence: true, :numericality => { :greater_than_or_equal_to => 0  }
end
