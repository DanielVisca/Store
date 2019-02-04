class Cart < ApplicationRecord
  has_many :cart_item
  #accepts_nested_attributes_for :cart_item, reject_if: :all_blank, allow_destroy: true 
end
