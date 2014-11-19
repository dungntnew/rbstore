class Order < ActiveRecord::Base
  PAYMENT_TYPES = ["Check", "Credit card", "Paypal"]
  has_many :line_items, dependent: :destroy
  validates :name, :address, :email, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  
  # validate that the url entered for the image is valid.
  validates :ship_date, allow_blank:true, format: {
    with: %r{(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])}i,
    message: 'format must be yyyy/mm/dd'
  }
  
  def add_line_items_from_cart(cart) 
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
