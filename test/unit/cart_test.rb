require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "decrease line_item" do
    @cart = carts(:one)
    2.times do
      @line_item = @cart.add_product(products(:ruby).id)
      @line_item.save!
    end

    @cart.decrease_line_item(@line_item.id).save!
    assert_equal @cart.line_items.find(@line_item.id).quantity, 1

    @cart.decrease_line_item(@line_item.id).save!
    assert @cart.line_items.empty?
  end
end
