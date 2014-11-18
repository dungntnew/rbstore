class StoreController < ApplicationController
  include CurrentCounter
  include CurrentCart
  before_action :set_cart
  before_action :track, only: [:index]
  def index
    @products = Product.order(:title)
  end
end
