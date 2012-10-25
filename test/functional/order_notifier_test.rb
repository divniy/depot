require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [orders(:one).email], mail.to
    assert_equal ["divniy@gmail.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end
end
