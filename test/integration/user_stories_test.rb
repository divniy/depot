require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buy product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    get '/'
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.count
    assert_equal ruby_book, cart.line_items.first.product

    get '/orders/new'
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders", order: { name: "John Doe", address: "123 Main Street",
                                          email: "john@example.com", pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.count

    orders = Order.all
    assert_equal 1, orders.count
    order = orders.last

    assert_equal "John Doe", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "john@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.count
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["john@example.com"], mail.to
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
