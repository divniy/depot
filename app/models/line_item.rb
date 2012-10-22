class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product, :product_id
  belongs_to :cart
  belongs_to :product
end
