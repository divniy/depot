class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product, :product_id, :quantity
  belongs_to :cart
  belongs_to :product

  def total_price
    quantity * product.price
  end
end
