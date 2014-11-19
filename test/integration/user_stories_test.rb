require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  
  fixtures :products
  
  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
    
    # A user goes to the store index page
    get "/"
    assert_response :success
    assert_template "index"
    
    # They select a product, adding it to their cart
    # use an Ajax request to add to cart..
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
    
    # user check out and fill all data
    post_via_redirect "/orders",
    order: { name: "Dave Thomas",
      address: "123 The Street",
      email: "dave@example.com",
      pay_type: "Check"
    }
    assert_response :success
    assert_template 'index'
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    
    # ensure order created & line_items size = 1
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal order.name, "Dave Thomas"
    assert_equal order.address, "123 The Street"
    assert_equal order.email, "dave@example.com"
    assert_equal order.pay_type, "Check"
    assert_equal order.line_items.size, 1
    assert_equal order.line_items[0].product, ruby_book
    
    # Verify that email itself is correctly
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal "Sam Ruby <depot@example.com>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    
  end
  
  # test "the truth" do
  #   assert true
  # end
end
